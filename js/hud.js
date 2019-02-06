(($) => {
  document.addEventListener('DOMContentLoaded', () => {
    let container = $('#container');
    let content = $('.content');
    // let lastPage = 'manual';
    // container.addEventListener('click', (e) => {
    //   if (e.target.matches('[data-href]')) {
    //     let page = e.target.getAttribute('data-href');
    //     $('.active').classList.remove('active');
    //     $('[data-href=' + page + ']').classList.add('active');
    //     content.classList.remove(lastPage);
    //     content.classList.add(page);
    //     lastPage = page;
    //   }
    // });
    // $('.tabs [data-href= ' + lastPage + ']').classList.add('active');
    // content.classList.add(lastPage);

    scriptExamplesController(content);

    function scriptExamplesController(content) {
      hljs.initLineNumbersOnLoad();
      let select = $('.examples .select select');
      let code = $('.examples #code');
      let copy = $('.examples button.copy');
      let title  = $('.examples #code-title');
      let scripts = [];
      let options = "";
      let first;
      copy.addEventListener('click', (e) => {
        range = document.createRange();
        range.selectNodeContents(code);
        sel = window.getSelection();
        sel.removeAllRanges();
        sel.addRange(range);
      });
      fetch('js/script-examples.json')
        .then(function(response) {
          return response.json();
        }).then((json) => {
          scripts = json;
          scripts.forEach((item, i) => {
            first = first || item.name;
            options += `<option value="${i}">${item.name}</option>`
          });

          select.innerHTML = options;
          return fetch('lsl/' + scripts[0].script);
        }).then((response) => {
          return response.text();
        }).then((lsl) => {
          code.innerHTML = lsl;
          title.textContent = first;
          hljs.highlightBlock(code);
          hljs.lineNumbersBlock(code);
        });


      select.addEventListener('change', (e) => {
        fetch('lsl/' + scripts[e.target.value].script)
          .then((response) => {
            return response.text();
          }).then((lsl) => {
            code.innerHTML = lsl;
            title.textContent = scripts[e.target.value].name;
            hljs.highlightBlock(code);
            hljs.lineNumbersBlock(code);
          });
      })
    }
    
  });
})((q) => document.querySelector(q))
