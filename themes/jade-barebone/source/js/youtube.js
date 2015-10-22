// -----------------------------
// YouTube Player API
// ytData(動画ID)はjadeにて取得。
// -----------------------------

var ytPlayer = [];
var ytPlaying, ytStop, ytPlay;

var tag = document.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

function onYouTubeIframeAPIReady(){
    for(var i = 0; i < ytData.length; i++){
        ytPlayer[i] = new YT.Player('player0'+i, {
            width: '750',
            height: '400',
            videoId: ytData[i],
            playerVars: {
                wmode : "transparent"
            },
            events: {
                'onStateChange': onPlayerStateChange
            }
        });
    }
}

function onPlayerStateChange(event) {
    for(var i = 0; i < ytData.length; i++) {
        var thisState = ytPlayer[i].getPlayerState();
        if( thisState == 1 && ytPlaying == undefined) {
            ytPlaying = i;
        } else if(thisState == 1 && ytPlaying != i) {
            ytStop = ytPlaying;
            ytPlay = i;
        } else {
        }
    }
    if(ytStop != undefined) {
        ytPlayer[ytStop].pauseVideo();
        ytStop = undefined;
    }
    if(ytPlay != undefined) {
        ytPlaying = ytPlay;
        ytPlay = undefined;
    }
}