// ~/.finicky.js
export default {
    defaultBrowser: "Helium",
    handlers: [
        {
            match: "github.com/*",
            browser: {
                name: "Helium",
                appType: "appName",
                openInBackground: false,
                profile: "work",
            }
        },
    ],
};
