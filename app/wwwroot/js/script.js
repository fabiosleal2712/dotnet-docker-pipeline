
window.blazorResize = {
    registerResizeCallback: function (dotnetHelper) {
        window.addEventListener('resize', () => {
            dotnetHelper.invokeMethodAsync('OnBrowserResize', window.innerWidth);
        });
    }
};

window.getDimensions = function () {
    return {
        width: window.innerWidth,
        height: window.innerHeight
    };
};