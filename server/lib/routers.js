const GameKuis = require('./controllers/game_kuis');
const Login = require('./controllers/login');
const MemberComment = require('./controllers/member_chat');
const MemberJoin = require('./controllers/member_join');
const Ngetes = require('./controllers/ngetes');
const Register = require('./controllers/register');

const Api = require('express').Router();

// login sekarang
Api.post('/login', Login.sekarang);

// register
Api.post('/register', Register.now)

// game kuis
Api.post('/game-kuis', GameKuis.mulai)

// ngetes
Api.get('/ngetes', Ngetes.mulai)

// member join
Api.get('/member-join', MemberJoin.sekarang)

// member comment
Api.get('/member-chat', MemberComment.sekarang)

module.exports = Api;