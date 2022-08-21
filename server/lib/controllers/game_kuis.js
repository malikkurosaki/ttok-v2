const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const { WebcastPushConnection } = require('tiktok-live-connector');
const colors = require('colors');
const db = require('../db.js');

const prossesnya = [];

const mulai = expressAsyncHandler(async (req, res) => {
    const { userId, tiktokUsername } = req.body;
    let tiktokChatConnection = new WebcastPushConnection(tiktokUsername);

    if (userId && tiktokUsername) {

        tiktokChatConnection.connect().then(state => {
            console.info(`Connected to roomId ${state.roomId}`.yellow);
            let proses = prossesnya.find(p => p.userId === userId && p.tiktokUsername === tiktokUsername);
            if (!proses) {
                console.info(`${userId} (${tiktokUsername}) is now listening to ${state.roomId}`.bgCyan.white);
                let sekarang = {
                    userId,
                    tiktokUsername,
                    roomId: state.roomId,
                    status: 'mulai',
                    waktu: new Date(),
                    connection: tiktokChatConnection
                }

                prossesnya.push(sekarang);
                listener(tiktokChatConnection, userId, state.roomId);
                res.status(201).send(state.roomId)
            } else {
                console.log(`owner : ${userId}`.bgGreen, 'Sudah ada prosesnya'.bgRed.white);
                res.status(201).send(state.roomId)
            }

        }).catch(err => {
            console.error(`owner : ${userId}`.bgGreen, 'Failed to connect', err);
            res.status(400).send("gagal untuk konek ke room , periksa insternet")
        })


    } else {
        res.status(403).send("masukkan username dan id")
    }
});

const GameKuis = { mulai };
module.exports = GameKuis


function listener(tiktokChatConnection, userId, roomId) {
    tiktokChatConnection.on('chat', async data => {
        console.log(`owner : ${userId}`.bgGreen, `${data.uniqueId} (userId:${data.userId}) writes: ${data.comment}`.green);
        await prisma.member.upsert({
            where: {
                id: `${data.uniqueId}`
            },
            create: {
                id: `${data.uniqueId}`,
                userId: `${userId}`,
                nickname: `${data.userId}`,
                profilePictureUrl: `${data.profilePictureUrl}`,
                uniqueId: `${data.uniqueId}`
            },
            update: {
                userId: `${userId}`,
                nickname: `${data.userId}`,
                profilePictureUrl: `${data.profilePictureUrl}`,
                uniqueId: `${data.uniqueId}`
            }
        })

        await prisma.memberComment.create({
            data: {
                comment: data.comment,
                userId: `${userId}`,
                memberId: `${data.uniqueId}`,
                roomId: `${roomId}`,
            }
        })
        db.ref('/ttok').child(userId).child('chat').set({
            userId,
            tiktokUsername: data.uniqueId,
            comment: data.comment,
        });
    })

    tiktokChatConnection.on('disconnected', () => {
        console.log(`owner : ${userId}`.bgGreen, 'Disconnected :('.red);
    })

    tiktokChatConnection.on('streamEnd', () => {
        console.log(`owner : ${userId}`.bgGreen, 'Stream ended'.inverse);
    })

    tiktokChatConnection.on('member', async data => {
        console.log(`owner : ${userId}`.bgGreen, `${data.uniqueId} joins the stream!`.yellow);
        await prisma.member.upsert({
            where: {
                id: `${data.uniqueId}`
            },
            create: {
                id: `${data.uniqueId}`,
                userId: `${userId}`,
                nickname: `${data.userId}`,
                profilePictureUrl: `${data.profilePictureUrl}`,
                uniqueId: `${data.uniqueId}`
            },
            update: {
                userId: `${userId}`,
                nickname: `${data.userId}`,
                profilePictureUrl: `${data.profilePictureUrl}`,
                uniqueId: `${data.uniqueId}`
            }
        })

        await prisma.memberJoin.upsert({
            where: {
                id: `${data.uniqueId}`
            },
            create: {
                id: `${data.uniqueId}`,
                userId: `${userId}`,
                memberId: `${data.uniqueId}`,
                roomId: `${roomId}`,
            },
            update: {
                userId: `${userId}`,
                memberId: `${data.uniqueId}`,
                roomId: `${roomId}`,
            }
        })

        db.ref('/ttok').child(userId).child('join').set({
            userId,
            tiktokUsername: data.uniqueId
        });
    })

}

