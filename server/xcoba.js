const { WebcastPushConnection } = require('tiktok-live-connector');
live();
function live() {
    let tiktokChatConnection = new WebcastPushConnection("ayrah1313");

    tiktokChatConnection.connect().then(state => {
        console.info(`Connected to roomId ${state.roomId}`);

    }).catch(err => {
        console.error('Failed to connect', err);

    })


    tiktokChatConnection.on('chat', data => {
        console.log(`${data.uniqueId} (userId:${data.userId}) writes: ${data.comment}`);
    })

    tiktokChatConnection.on('disconnected', () => {
        console.log('Disconnected :(');
    })

    tiktokChatConnection.on('streamEnd', () => {
        console.log('Stream ended');
    })

    tiktokChatConnection.on('member', data => {
        console.log(`${data.uniqueId} joins the stream!`);
    })

    
}