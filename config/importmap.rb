# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "detail", to: "detail.js" 
pin "info", to: "info.js" 
pin "comment", to: "comment.js" 
pin "more_description", to: "more_description.js"
pin "article_summary", to: "article_summary.js"
pin "speak", to: "speak.js" 