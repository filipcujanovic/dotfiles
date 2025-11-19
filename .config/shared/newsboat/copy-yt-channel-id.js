const subscribe_button = document.querySelector('yt-subscribe-button-view-model');
const button = document.createElement('button');
button.textContent = 'ᯤ RSS Subscribe'
button.id = 'rss-feed-subscribe-button';
button.addEventListener('click', () => {
    navigator.clipboard.writeText(`https://www.youtube.com/feeds/videos.xml?channel_id=${window.ytInitialData.metadata.channelMetadataRenderer.externalId} "youtube"`);
});
subscribe_button.insertAdjacentElement('afterend', button);
