// Lint html

require('mocha-htmllint')(['index.html'], {
    'attr-name-style': 'dash',
    'id-class-style': 'dash',
    'tag-bans': false,
});
