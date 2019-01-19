(($) => {
  document.addEventListener('DOMContentLoaded', () => {
    let container = $('#container');
    container.innerHTML = `
      <h1>Google Analytics for Second Life</h1>
      <ul>
        <li tabindex="0" data-href="manual">Manual</li>
        <li tabindex="0" data-href="examples">Script Examples</li>
        <li tabindex="0" data-href="affiliate">Affiliate Script</li>
      </ul>
      <div class="content"></div>
    `;
    
    container.addEventListener('click', (e) => {
      if (e.target.matches('[data-href]')) {
        let page = e.target.getAttribute('data-href');
        let content = $('.content');
        switch (page) {
          case 'manual':
            content.innerHTML = manual;
            break;
          case 'examples':
            content.innerHTML = '';
            break;
          case 'affiliate':
            content.innerHTML = '';
        }
      }
    });
    
    let manual = `
    <h2>Manual</h2>
    <h3>Who is this for</h3>
    <h3>What is possible with Google Analytics</h3>
    <h3>GA for Sims and parcels</h3>
    <h3>GA for HUDs and Dialogs</h3>
    <h3>GA for SL Marketplace</h3>
    `;
  });
})((q) => document.querySelector(q))
