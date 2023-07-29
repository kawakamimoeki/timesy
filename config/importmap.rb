# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "easymde", to: "https://ga.jspm.io/npm:easymde@2.18.0/src/js/easymde.js"
pin "codemirror", to: "https://ga.jspm.io/npm:codemirror@5.65.13/lib/codemirror.js"
pin "codemirror-spell-checker", to: "https://ga.jspm.io/npm:codemirror-spell-checker@1.1.2/src/js/spell-checker.js"
pin "codemirror/", to: "https://ga.jspm.io/npm:codemirror@5.65.13/"
pin "fs", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/fs.js"
pin "typo-js", to: "https://ga.jspm.io/npm:typo-js@1.2.3/typo.js"
pin "marked", to: "https://ga.jspm.io/npm:marked@5.1.1/lib/marked.esm.js"
pin "picmo", to: "https://ga.jspm.io/npm:picmo@5.8.5/dist/index.js"
pin "@picmo/popup-picker", to: "https://ga.jspm.io/npm:@picmo/popup-picker@5.8.5/dist/index.js"
