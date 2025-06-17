#!/bin/sh

THEME_PATH="/usr/lib/lua/luci/view/themes/argon"
HEADER="$THEME_PATH/header.htm"
FOOTER="$THEME_PATH/footer.htm"
NAVBAR="$THEME_PATH/navbar.htm"
CSS_PATH="/www/luci-static/argon/css/nav.css"

# 1. Create navbar.htm file
cat <<'EOF' > "$NAVBAR"
<nav class='mobile' id='ATnav'>
  <ul>
    <li><a href='<%=url("admin/status/overview")%>'><svg class='s-size' viewBox='0 0 16 16'><path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L2 8.207V13.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V8.207l.646.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5ZM13 7.207V13.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V7.207l5-5 5 5Z"/></svg><span>Home</span></a></li>
    <li><a href='<%=url("admin/services/openclash")%>'><svg class='s-size' viewBox='0 0 16 16'><path d="M8 8c.828 0 1.5-.895 1.5-2S8.828 4 8 4s-1.5.895-1.5 2S7.172 8 8 8Z"/><path d="M11.953 8.81c-.195-3.388-.968-5.507-1.777-6.819C9.707 1.233 9.23.751 8.857.454a3.495 3.495 0 0 0-.463-.315A2.19 2.19 0 0 0 8.25.064.546.546 0 0 0 8 0a.549.549 0 0 0-.266.073 2.312 2.312 0 0 0-.142.08 3.67 3.67 0 0 0-.459.33c-.37.308-.844.803-1.31 1.57-.805 1.322-1.577 3.433-1.774 6.756l-1.497 1.826-.004.005A2.5 2.5 0 0 0 2 12.202V15.5a.5.5 0 0 0 .9.3l1.125-1.5c.166-.222.42-.4.752-.57.214-.108.414-.192.625-.281l.198-.084c.7.428 1.55.635 2.4.635.85 0 1.7-.207 2.4-.635.067.03.132.056.196.083.213.09.413.174.627.282.332.17.586.348.752.57l1.125 1.5a.5.5 0 0 0 .9-.3v-3.298a2.5 2.5 0 0 0-.548-1.562l-1.499-1.83Z"/></svg><span>OpenClash</span></a></li>
    <li><a href='<%=url("admin/services/passwall")%>'><svg class='s-size' viewBox='0 0 16 16'><path d="M4.5 5a.5.5 0 1 0 0-1 .5.5 0 0 0 0 1zM3 4.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z"/><path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v1a2 2 0 0 1-2 2H8.5v3a1.5 1.5 0 0 1 1.5 1.5h5.5a.5.5 0 0 1 0 1H10A1.5 1.5 0 0 1 8.5 14h-1A1.5 1.5 0 0 1 6 12.5H.5a.5.5 0 0 1 0-1H6A1.5 1.5 0 0 1 7.5 10V7H2a2 2 0 0 1-2-2V4z"/></svg><span>Passwall</span></a></li>
    <li><a href='<%=url("admin/services/ttyd")%>'><svg viewBox='0 0 16 16'><path d="M0 3a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3zm9.5 5.5h-3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1zm-6.354-.354a.5.5 0 1 0 .708.708l2-2a.5.5 0 0 0 0-.708l-2-2a.5.5 0 1 0-.708.708L4.793 6.5 3.146 8.146z"/></svg><span>Terminal</span></a></li>
    <li><a href='#'><svg viewBox='0 0 16 16'><path fill-rule="evenodd" d="M8 10a.5.5 0 0 0 .5-.5V3.707l2.146 2.147a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 1 0 .708.708L7.5 3.707V9.5a.5.5 0 0 0 .5.5zm-7 2.5a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 0 1h-13a.5.5 0 0 1-.5-.5z"/></svg><span>Top</span></a></li>
  </ul>
</nav>
EOF
echo "[✓] File navbar.htm dibuat di: $NAVBAR"

# 2. Tambah link nav.css jika belum ada
if ! grep -q "nav.css" "$HEADER"; then
  sed -i '/cascade\.css.*>/a\\t<link rel="stylesheet" href="<%=media%>/css/nav.css">' "$HEADER"
  echo "[✓] Menambahkan <link> nav.css ke header.htm"
fi

# 3. Include navbar.htm di header.htm jika belum ada
if ! grep -q "navbar.htm" "$HEADER"; then
  sed -i '/<div class="main">/i\<%- include("themes/argon/navbar") %>' "$HEADER"
  echo "[✓] Menambahkan include navbar.htm ke header.htm"
fi

# 4. Tambahkan script JS ke footer.htm jika belum ada
if ! grep -q "prevScrollpos" "$FOOTER"; then
  echo "[✓] Menambahkan JavaScript auto-hide navbar ke footer.htm"
  cat <<'EOF' >> "$FOOTER"
<script type="text/javascript">
var prevScrollpos = window.pageYOffset;
window.onscroll = function() {
  var currentScrollPos = window.pageYOffset;
  if (prevScrollpos > currentScrollPos) {
    document.getElementById("ATnav").style.bottom = "0";
  } else {
    document.getElementById("ATnav").style.bottom = "-80px";
  }
  prevScrollpos = currentScrollPos;
}
</script>
EOF
fi

# 5. Buat nav.css
mkdir -p "$(dirname "$CSS_PATH")"
cat <<'EOF' > "$CSS_PATH"
nav.mobile {
  display: flex;
  position: fixed;
  bottom: 0;
  width: 100%;
  padding: 0.5rem 0;
  background: var(--primary);
  z-index: 9999;
  margin: 0 auto;
  transition: bottom 0.3s;
}
nav.mobile ul {
  list-style: none;
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  margin: 0;
  padding: 0;
}
nav.mobile ul li {
  display: flex;
  flex-direction: column;
  align-items: center;
  font-size: 0.7rem;
  flex-grow: 1;
}
nav.mobile ul li a {
  color: #222;
  font-size: inherit;
  text-decoration: none;
}
nav.mobile ul li a svg {
  width: 25px;
  height: 25px;
  display: block;
  margin: 0 auto;
}
EOF

echo "[✓] File nav.css dibuat di: $CSS_PATH"
echo "[✓] Injeksi selesai!"
