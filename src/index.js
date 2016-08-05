// pull in desired CSS/SASS files
require( './styles/app.scss' );

// inject bundled Elm app into div#main
var Elm = require( './elm/App' );
Elm.Main.embed( document.getElementById( 'main' ) );
