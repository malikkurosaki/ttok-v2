const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');


const now = expressAsyncHandler(async (req, res) => {
    const body = req.body;

    const lgn = await prisma.user.findUnique({
        where: {
            email: body.email
        }
    });

    console.log(lgn);

    if (!lgn) {
        const rgs = await prisma.user.create({
            data: {
                name: body.name,
                email: body.email,
                password: body.password
            },
        })

        if (rgs) {
            res.status(201).send("register berhasil")
        } else {
            res.status(409).send("register gagal : error");
        }

    } else {
        res.status(409).send("email sudah digunakan")
    }
});

const Register = { now }
module.exports = Register