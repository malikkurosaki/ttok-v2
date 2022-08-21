#!/usr/bin/env node

const prompts = require('prompts');
const fs = require('fs');
const path = require('path');
const _ = require('lodash');
const colors = require('colors');
const beautify = require('js-beautify');
const { execSync } = require('child_process');

execSync(`nodemon .`, { stdio: "inherit", cwd: path.join(__dirname, `./../../../server`) })