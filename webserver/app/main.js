const express = require('express');
const app = express();

// 各ルートの設定
const routes = [
    { path: '/', action: 'index', message: 'ホーム画面です\n' },
    { path: '/about', action: 'about', message: 'これはAboutページです\n' },
    { path: '/faq', action: 'faq', message: 'これはFAQページです\n' },
    { path: '/portfolio', action: 'portfolio', message: 'これはPortfolioページです\n' },
    { path: '/error', action: 'error', message: 'これはerrorページです\n' },
];

routes.forEach(route => {
    app.get(route.path, (req, res) => {
        res.send(route.message);
    });
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
