const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const uuid = require('uuid').v4;
const { WebcastPushConnection } = require('tiktok-live-connector');

const prosesnya = [];

const mulai = expressAsyncHandler(async (req, res) => {
    
    let tiktokChatConnection = new WebcastPushConnection("ayrah1313");
    tiktokChatConnection.connect().then(state => {
        console.info(`Connected to roomId ${state.roomId}`);

        

        res.status(201).send(state.roomId)
    }).catch(err => {
        console.error('Failed to connect', err);
        res.status(400).send(err)
    })
    
})

const Ngetes = {mulai}
module.exports = Ngetes;