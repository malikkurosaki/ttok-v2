#!/usr/bin/env node
const prompts = require('prompts');
const fs = require('fs');
const path = require('path');
const _ = require('lodash');
const colors = require('colors');
const beautify = require('js-beautify')

prompts({
    type: 'text',
    name: 'name',
    message: 'Enter a name'
}).then(({ name }) => {
    
    const target = path.join(__dirname, `./../con/${_.snakeCase(name)}.js`);
    if(fs.existsSync(target)) return console.log('nama sudah terdaftar'.red)
    
    const temp = `
    #!/usr/bin/env node
    const prompts = require('prompts');
    const fs = require('fs');
    const path = require('path');
    const _ = require('lodash');
    const colors = require('colors');
    const beautify = require('js-beautify');
    const { execSync } = require('child_process');
    `

    fs.writeFileSync(target, beautify(temp))
    console.log("item telah dibuat sukses".green)

}).catch( e => console.log("bey ...".red))