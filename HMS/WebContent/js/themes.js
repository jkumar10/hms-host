var theme;
window.onload = function() {
    theme = getCookie("theme");
    console.log("theme:" + theme);
    if(theme == '') {
        theme = 'default';
    }
    applyTheme(null, theme);
};

function invertTheme() {
    var old_theme = theme;
    if(theme == 'default') {
        theme = 'dark';
    }
    else {
        theme = 'default';
    }

    setCookie("theme", theme, 9999);
    applyTheme(old_theme, theme);
}

function applyTheme(old_theme, new_theme) {
    if(old_theme != null)
        document.body.classList.remove("theme-" + old_theme)
    document.body.classList.add("theme-" + new_theme); //Adds theme to the body
//Themes are defined in the theme.css file which should be imported with this file
}