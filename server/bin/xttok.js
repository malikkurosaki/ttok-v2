#!/usr/bin/env node
const prompts = require('prompts');
const fs = require('fs');
const path = require('path');
const _ = require('lodash');

const colors = require('colors');
const execSync = require('child_process').execSync;

const def = fs.readdirSync(path.join(__dirname, './def'));
const con = fs.readdirSync(path.join(__dirname, `./con`))

console.log(`

  d8     d8            888   _   
_d88__ _d88__  e88~-_  888 e~ ~  
 888    888   d888   i 888d8b    
 888    888   8888   | 888Y88b   
 888    888   Y888   ' 888 Y88b  
 "88_/  "88_/  "88_-~  888  Y88b 
 ===============================
 @malikkurosaki          v.1.0.0
                                 
`.cyan)

prompts({
    type: 'select',
    name: 'menu',
    message: 'Select a menu',
    choices: [
        ...def.map((item) => {
            return {
                title: item.split('.')[0].replace("_", " ").toUpperCase().yellow,
                value: {
                    file: item,
                    path: "def"
                }
            };
        }),
        ...con.map( item => {
            return {
                title: item.split('.')[0].replace("_", " "),
                value: {
                    file: item,
                    path: "con"
                }
            }
        })
    ]
}).then(({ menu }) => {
    execSync(`node ${menu.file}`, { stdio: 'inherit', cwd: path.join(__dirname, `./${menu.path}`) });
}).catch(e => console.log("bey ...".red))