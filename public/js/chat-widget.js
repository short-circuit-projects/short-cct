(function () {
  'use strict';

  const WIDGET_STYLE_ID = 'sc-chat-widget-styles';

  function shouldEnableWidget(pathname) {
    const path = (pathname || '').toLowerCase();

    const excluded = [
      '/login.html',
      '/signup.html',
      '/forgot-password.html',
      '/reset-password.html',
      '/checkout-success.html',
      '/checkout-cancel.html',
      '/admin/',
      '/account/',
    ];

    for (const blocked of excluded) {
      if (path === blocked || path.startsWith(blocked)) {
        return false;
      }
    }

    const highIntent = [
      '/',
      '/index.html',
      '/shop.html',
      '/smartwatch.html',
      '/ballbeam.html',
      '/challenge.html',
      '/cart.html',
      '/orders.html',
    ];

    return highIntent.includes(path);
  }

  function injectWidgetStyles() {
    if (document.getElementById(WIDGET_STYLE_ID)) {
      return;
    }

    const style = document.createElement('style');
    style.id = WIDGET_STYLE_ID;
    style.textContent = [
      '.sc-chat-widget{position:fixed;right:24px;bottom:24px;z-index:9998;font-family:\'Open Sans\',sans-serif;}',
      '.sc-chat-toggle{width:60px;height:60px;border:none;border-radius:50%;background:linear-gradient(135deg,var(--tech-green,#00ff88),#00d977);color:var(--navy,#1a2332);box-shadow:0 10px 28px rgba(0,255,136,.35);cursor:pointer;display:inline-flex;align-items:center;justify-content:center;transition:transform .25s ease,box-shadow .25s ease;}',
      '.sc-chat-toggle:hover{transform:translateY(-2px) scale(1.02);box-shadow:0 14px 34px rgba(0,255,136,.45);}',
      '.sc-chat-toggle svg{width:24px;height:24px;}',
      '.sc-chat-panel{position:absolute;right:0;bottom:76px;width:min(380px,calc(100vw - 24px));height:min(560px,calc(100vh - 130px));background:var(--white,#fff);border-radius:14px;border:1px solid rgba(0,191,255,.2);box-shadow:0 24px 60px rgba(0,0,0,.24);display:flex;flex-direction:column;overflow:hidden;opacity:0;visibility:hidden;pointer-events:none;transform:translateY(14px) scale(.98);transition:opacity .22s ease,transform .22s ease,visibility .22s ease;}',
      '.sc-chat-widget.is-open .sc-chat-panel{opacity:1;visibility:visible;pointer-events:auto;transform:translateY(0) scale(1);}',
      '.sc-chat-header{padding:14px 16px;border-bottom:1px solid rgba(0,191,255,.18);display:flex;align-items:center;justify-content:space-between;background:linear-gradient(180deg,rgba(0,191,255,.08),rgba(0,255,136,.04));}',
      '.sc-chat-title{margin:0;font-family:\'Montserrat\',sans-serif;font-size:14px;color:var(--navy,#1a2332);font-weight:700;letter-spacing:.2px;}',
      '.sc-chat-status{font-size:12px;color:var(--dark-gray,#6c757d);}',
      '.sc-chat-close{border:none;background:transparent;color:var(--dark-gray,#6c757d);cursor:pointer;font-size:18px;line-height:1;padding:0 4px;}',
      '.sc-chat-messages{flex:1;overflow-y:auto;padding:14px;display:flex;flex-direction:column;gap:10px;background:#f8fbff;}',
      '.sc-chat-row{display:flex;width:100%;}',
      '.sc-chat-row.user{justify-content:flex-end;}',
      '.sc-chat-row.bot,.sc-chat-row.system{justify-content:flex-start;}',
      '.sc-chat-bubble{max-width:84%;padding:10px 12px;border-radius:12px;font-size:13px;line-height:1.45;white-space:pre-wrap;word-wrap:break-word;border:1px solid transparent;}',
      '.sc-chat-bubble.user{background:linear-gradient(135deg,var(--electric-blue,#00bfff),var(--cyber-purple,#8b5cf6));color:var(--white,#fff);border-bottom-right-radius:4px;}',
      '.sc-chat-bubble.bot{background:var(--white,#fff);color:var(--navy,#1a2332);border-color:#d7e7f4;border-bottom-left-radius:4px;}',
      '.sc-chat-bubble.system{background:rgba(255,107,107,.12);color:#b42318;border-color:rgba(255,107,107,.4);border-bottom-left-radius:4px;}',
      '.sc-chat-typing{display:inline-flex;align-items:center;gap:6px;font-size:12px;color:var(--dark-gray,#6c757d);}',
      '.sc-chat-dot{width:5px;height:5px;border-radius:50%;background:var(--dark-gray,#6c757d);animation:scChatPulse 1s infinite ease-in-out;}',
      '.sc-chat-dot:nth-child(2){animation-delay:.12s;}.sc-chat-dot:nth-child(3){animation-delay:.24s;}',
      '.sc-chat-composer{border-top:1px solid rgba(0,191,255,.18);padding:10px;background:var(--white,#fff);display:flex;gap:8px;}',
      '.sc-chat-input{flex:1;border:1px solid #c8d7e6;border-radius:10px;padding:10px 11px;font-size:13px;outline:none;color:var(--navy,#1a2332);background:#fff;}',
      '.sc-chat-input:focus{border-color:var(--electric-blue,#00bfff);box-shadow:0 0 0 2px rgba(0,191,255,.18);}',
      '.sc-chat-send{border:none;border-radius:10px;background:linear-gradient(135deg,var(--tech-green,#00ff88),#00d977);color:var(--navy,#1a2332);padding:0 14px;font-weight:700;cursor:pointer;transition:transform .2s ease;min-width:72px;}',
      '.sc-chat-send:hover{transform:translateY(-1px);}',
      '.sc-chat-send:disabled{opacity:.65;cursor:not-allowed;transform:none;}',
      '@keyframes scChatPulse{0%,80%,100%{opacity:.25;transform:scale(.9)}40%{opacity:1;transform:scale(1.05)}}',
      '@media (max-width:768px){.sc-chat-widget{right:12px;bottom:12px}.sc-chat-panel{right:0;width:calc(100vw - 24px);max-height:calc(100vh - 98px);bottom:72px}.sc-chat-toggle{width:56px;height:56px}}'
    ].join('');

    document.head.appendChild(style);
  }

  function createWidgetRoot() {
    const wrapper = document.createElement('div');
    wrapper.className = 'sc-chat-widget';
    wrapper.setAttribute('data-sc-chat-widget', '');
    wrapper.setAttribute('data-api-url', '/api/chat');

    wrapper.innerHTML =
      '<div class="sc-chat-panel" data-chat-panel aria-hidden="true" aria-label="Short Circuit Chatbot">' +
      '  <div class="sc-chat-header">' +
      '    <div>' +
      '      <h3 class="sc-chat-title">Short Circuit Chatbot</h3>' +
      '      <span class="sc-chat-status" data-chat-status>Ready</span>' +
      '    </div>' +
      '    <button class="sc-chat-close" type="button" data-chat-close aria-label="Close chat">&times;</button>' +
      '  </div>' +
      '  <div class="sc-chat-messages" data-chat-messages aria-live="polite">' +
      '    <div class="sc-chat-row bot">' +
      '      <div class="sc-chat-bubble bot">Welcome to Short Circuit. Ask me about projects, lessons, or platform navigation.</div>' +
      '    </div>' +
      '  </div>' +
      '  <form class="sc-chat-composer" data-chat-composer autocomplete="off">' +
      '    <input class="sc-chat-input" data-chat-input type="text" name="message" placeholder="Message" aria-label="Type your message" required>' +
      '    <button class="sc-chat-send" data-chat-send type="submit">Send</button>' +
      '  </form>' +
      '</div>' +
      '<button class="sc-chat-toggle" type="button" data-chat-toggle aria-label="Open chat" aria-expanded="false">' +
      '  <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">' +
      '    <path d="M8 10h8M8 14h5M4 6.8C4 5.81 4.81 5 5.8 5h12.4c.99 0 1.8.81 1.8 1.8v8.4c0 .99-.81 1.8-1.8 1.8H10l-4.5 3v-3H5.8c-.99 0-1.8-.81-1.8-1.8V6.8z" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>' +
      '  </svg>' +
      '</button>';

    return wrapper;
  }

  function initWidget(root) {
    if (!root || root.dataset.chatInit === 'true') {
      return;
    }

    const panel = root.querySelector('[data-chat-panel]');
    const toggleBtn = root.querySelector('[data-chat-toggle]');
    const closeBtn = root.querySelector('[data-chat-close]');
    const messagesEl = root.querySelector('[data-chat-messages]');
    const composerEl = root.querySelector('[data-chat-composer]');
    const inputEl = root.querySelector('[data-chat-input]');
    const sendBtnEl = root.querySelector('[data-chat-send]');
    const statusTextEl = root.querySelector('[data-chat-status]');
    const apiUrl = root.dataset.apiUrl || '/api/chat';

    if (!panel || !toggleBtn || !messagesEl || !composerEl || !inputEl || !sendBtnEl || !statusTextEl) {
      return;
    }

    let typingRowEl = null;

    function setOpen(open) {
      root.classList.toggle('is-open', open);
      toggleBtn.setAttribute('aria-expanded', open ? 'true' : 'false');
      panel.setAttribute('aria-hidden', open ? 'false' : 'true');
      if (open) {
        requestAnimationFrame(function () {
          inputEl.focus();
          scrollToBottom();
        });
      }
    }

    function scrollToBottom() {
      messagesEl.scrollTop = messagesEl.scrollHeight;
    }

    function addMessage(role, text) {
      const row = document.createElement('div');
      row.className = 'sc-chat-row ' + role;

      const bubble = document.createElement('div');
      bubble.className = 'sc-chat-bubble ' + role;
      bubble.textContent = text;

      row.appendChild(bubble);
      messagesEl.appendChild(row);
      scrollToBottom();
      return row;
    }

    function showTyping() {
      if (typingRowEl) {
        return;
      }

      typingRowEl = document.createElement('div');
      typingRowEl.className = 'sc-chat-row bot';
      typingRowEl.innerHTML =
        '<div class="sc-chat-bubble bot">' +
        '  <span class="sc-chat-typing" aria-label="Assistant is typing">' +
        '    Typing' +
        '    <span class="sc-chat-dot"></span>' +
        '    <span class="sc-chat-dot"></span>' +
        '    <span class="sc-chat-dot"></span>' +
        '  </span>' +
        '</div>';

      messagesEl.appendChild(typingRowEl);
      scrollToBottom();
    }

    function hideTyping() {
      if (!typingRowEl) {
        return;
      }

      typingRowEl.remove();
      typingRowEl = null;
    }

    async function sendMessage() {
      const message = inputEl.value.trim();
      if (!message) {
        return;
      }

      addMessage('user', message);
      inputEl.value = '';

      sendBtnEl.disabled = true;
      inputEl.disabled = true;
      statusTextEl.textContent = 'Thinking...';
      showTyping();

      try {
        const response = await fetch(apiUrl, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ message: message })
        });

        if (!response.ok) {
          let errorText = 'Request failed (' + response.status + ')';
          try {
            const errJson = await response.json();
            if (errJson && errJson.error) {
              errorText = errJson.error;
            }
          } catch (_error) {
            // Keep default error text.
          }
          throw new Error(errorText);
        }

        const data = await response.json();
        const reply = data && typeof data.reply === 'string' && data.reply.trim()
          ? data.reply.trim()
          : 'I could not generate a response this time.';

        hideTyping();
        addMessage('bot', reply);
        statusTextEl.textContent = 'Ready';
      } catch (error) {
        hideTyping();
        const errorText = error instanceof Error
          ? error.message
          : 'Something went wrong. Please try again.';
        addMessage('system', 'Error: ' + errorText);
        statusTextEl.textContent = 'Error';
      } finally {
        sendBtnEl.disabled = false;
        inputEl.disabled = false;
        inputEl.focus();
      }
    }

    toggleBtn.addEventListener('click', function () {
      setOpen(!root.classList.contains('is-open'));
    });

    if (closeBtn) {
      closeBtn.addEventListener('click', function () {
        setOpen(false);
      });
    }

    composerEl.addEventListener('submit', function (event) {
      event.preventDefault();
      sendMessage();
    });

    inputEl.addEventListener('keydown', function (event) {
      if (event.key === 'Enter' && !event.shiftKey) {
        event.preventDefault();
        sendMessage();
      }
    });

    root.dataset.chatInit = 'true';
  }

  document.addEventListener('DOMContentLoaded', function () {
    injectWidgetStyles();

    let roots = document.querySelectorAll('[data-sc-chat-widget]');

    if (roots.length === 0 && shouldEnableWidget(window.location.pathname)) {
      const injectedRoot = createWidgetRoot();
      document.body.appendChild(injectedRoot);
      roots = document.querySelectorAll('[data-sc-chat-widget]');
    }

    roots.forEach(initWidget);
  });
})();
