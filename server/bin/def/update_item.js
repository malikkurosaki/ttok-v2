#!/usr/bin/env node
const prompts = require('prompts');
const fs = require('fs');
const path = require('path');
const _ = require('lodash');
const colors = require('colors');
const beautify = require('js-beautify')

const con = fs.readdirSync(path.join(__dirname, `./../con`))
if (_.isEmpty(con)) return console.log('menu kosong'.red)
prompts({
    type: "select",
    name: "pilih",
    message: "pilihlah salah satunya",
    choices: con.map( e => {
        return {
            title: e.replace("_" , " ").split(".")[0],
            value: e
        }
    })
}).then(({pilih}) => {
    prompts({
        type: "text",
        name: "nama",
        message: "masukkan nama baru",
    }).then(({nama}) => {
        fs.rename(path.join(__dirname, `./../con/${pilih}`), path.join(__dirname, `./../con/${_.snakeCase(nama)}.js`), (x) => {
            if(x != null) return console.log(`${x}`.red)
            console.log('item telah di rename'.green)
        })

        
    })
}).catch( e => console.log("bye...".red))