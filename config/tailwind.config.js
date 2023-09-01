const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  darkMode: "class",
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.html.erb",
    "./app/views/**/*.erb",
  ],
  theme: {
    extend: {
      colors: {
        background: "#edf2f7",
        "dark-background": "rgb(21, 32, 43)",
        "dark-border": "#30363d",
        "dark-card": "rgb(21, 32, 43)",
      },
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
      animation: {
        "fade-in": "fade-in 0.1s cubic-bezier(0.390, 0.575, 0.565, 1.000) both",
        down: "down 0.1s cubic-bezier(0.390, 0.575, 0.565, 1.000) both",
      },
      keyframes: {
        "fade-in": {
          "0%": {
            opacity: "0",
          },
          to: {
            opacity: "1",
          },
        },
        down: {
          "0%": {
            transform: "translateY(-3%)",
            opacity: "0",
          },
          to: {
            transform: "translateY(0)",
            opacity: "1",
          },
        },
      },
    },
  },
  plugins: [
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
