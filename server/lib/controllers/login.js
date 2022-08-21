const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');

const sekarang = expressAsyncHandler(async (req, res) => {
    const body = req.body;

    const lgn = await prisma.user.findFirst({
        where: {
            AND: {
                email: body.email,
                password: body.password
            }
        },
        select: {
            email: true,
            name: true,
            id: true
        }
    })

    res.status(lgn? 200: 401).send(lgn);
})

const Login = { sekarang }

module.exports = Login;