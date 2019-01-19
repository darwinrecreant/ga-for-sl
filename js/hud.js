(($) => {
  document.addEventListener('DOMContentLoaded', () => {
    let container = $('#container');
    container.innerHTML = `
      <h1>Google Analytics for Second Life</h1>
      <ul class="tabs">
        <li tabindex="0" data-href="manual">Manual</li>
        <li tabindex="0" data-href="examples">Script Examples</li>
        <li tabindex="0" data-href="affiliate">Affiliate Script</li>
      </ul>
      <div class="content"></div>
    `;
    
    container.addEventListener('click', (e) => {
      if (e.target.matches('[data-href]')) {
        let page = e.target.getAttribute('data-href');
        $('.tabs .active').classList.remove('active');
        $('.tabs [data-href=' + page + ']').classList.add('active');
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
            break;
        }
      }
    });
    
    let manual = `
    <h3>About</h3>

<p>One of the difficulties professionals in Second Life have to deal with is the lack of feedback for their 
products. Currently, if you wanted to analyze how your product is used, what are the most liked/used featured, 
or how engaging is your in-world store, you had to either make your own analytics storage and processing 
implementation, which is very costly, or rely on sub-par analytics services with limited feaures, or simply 
had to rely on anectdotal feedback from customers.</p>

<p>Google Anlytics is the defacto standard analytics service for the web. It has an endless list of features, 
is very flexible, and did I mention free!. <span class="product-name">Google Anlytics for Second Life</span> is a 
Second Life connector between Google Analytics and in-world objects. By opening a google analytics account and 
using this product it is possible to track analytics for you products, parcels, vendors, games, and just about 
anything you can imagine that is scripted.</p>

    <h3>Who is this for</h3>
<p>This product is geared towards sim/land owners and merchants. It provides an api for scripters to implement 
analytics in the product they are working on. There are even several general usecase sample scripts that will
work by simply placing into your land or vendor.</p>
    <h3>What is possible with Google Analytics</h3>
    <h3>GA for Sims and parcels</h3>
    <h3>GA for HUDs and Dialogs</h3>
    <h3>GA for SL Marketplace</h3>
    <h3>Privacy</h3>
<p><span class="product-name">Google Analytics for Second Life</span> is a limited version of the web product, 
and therefore does not use cookies, has no access to visitor ip's, or any of the other features of the SL viewer. 
Out of the box, this product cannot track user data, other than simple counters for interactions with in the sim. 
Storing user identifiying data, such as name or uuid, is up to the scripters of products, but is against Google 
Analytics' policies, as well as some European laws. The makers of <span class="product-name">Google Analytics 
for Second Life</p> are not responsible for the misuse of Google and Second Life products.</p>
    `;
    
    $('.content').innerHTML = manual;
    $('.tabs [data-href=manual]').classList.add('active');
  });
})((q) => document.querySelector(q))
