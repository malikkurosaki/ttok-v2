const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');


const sekarang = expressAsyncHandler(async (req, res) => {
    const query = req.query;
    if (query.roomId == undefined || query.userId == undefined) {
        res.status(400).send("roomId dan userId tidak boleh kosong")

    } else {
        const member = await prisma.memberJoin.findMany({
            where: {
                roomId: query.roomId,
                userId: query.userId
            },
            take: 7,
            orderBy: {
                createdAt: 'desc'
            },
            include: {
                Member: true
            }
        })

        res.status(200).send(member)
    }
})

const MemberJoin = { sekarang }
module.exports = MemberJoin;