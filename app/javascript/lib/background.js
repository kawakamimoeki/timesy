const bmo = new MutationObserver((mutations) => {
  mutations.forEach((mutation) => {
    if (mutation.type === "childList") {
      document.querySelector("body").style.backgroundImage = `url(${document.querySelector("body").dataset.backgroundImage})`
    }
  })
})
bmo.observe(document.querySelector('body'), { childList: true })
