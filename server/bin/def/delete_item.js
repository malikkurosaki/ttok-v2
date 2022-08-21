#!/usr/bin/env node
const prompts = require('prompts');
const fs = require('fs');
const path = require('path');
const _ = require('lodash');
const colors = require('colors');
const beautify = require('js-beautify')

const con = fs.readdirSync(path.join(__dirname, `./../con`))
if(_.isEmpty(con)) return console.log('menu kosong'.red)

prompts({
    type: "multiselect",
    name: "del",
    message: "pilih salah satu atau lebih",
    choices: con.map(e => {
        return {
            title: e.replace("_", " ").split(".")[0],
            value: e
        }
    })
}).then(({ del }) => {
    del.forEach(element => {
        const target = path.join(__dirname, `./../con/${element}`);
        fs.unlinkSync(target);
        console.log(`${element} has been deleted`.yellow)
    });

}).catch(e => console.log("bye..".red))