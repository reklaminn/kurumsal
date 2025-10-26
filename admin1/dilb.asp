<!--#Include file="admin_menu1.asp"-->
<%response.Write(setchar(Request("sek"),"0"))
    sayfabaslik="SAYFA DİL DÜZENLE"
    'or ceviricode='"&request("sek")&"'
    dilsilislem="&islem=sildillerkate"
    dilduzenleislem="&islem=duzenledillerkate"
    %>
<%if request.QueryString("islemexcel")="" then %>
<div class="right_col" role="main">
    <div class="x_panel">
        <div class="x_title">
            <h2><%=sayfabaslik %></h2>
            <div class="clearfix"></div>
        </div>
         <%
        else
        Response.AddHeader "content-disposition","attachment; filename="&request.QueryString("islemexcel")&".XLS"
Response.AddHeader "pragma", "no-store"
Response.AddHeader "cache-control","no-store, no-cache, must-revalidate"
Response.ContentType ="application/vnd.ms-excel"
        end if%>
        <%
            if request("sek")="" then
else
    set mmmGenel = Con.Execute ("select ceviricode from diller1 where id = '"&request("sek")&"'")
if mmmGenel.eof then
else
ceviridileki=mmmGenel("ceviricode")
ceviridil=ceviridilek&"-"&ceviridileki
end if
close(mmmGenel)
end if
        %>
        <%if request.QueryString("islemexcel")="" then %>
        <form action="?filtre=1" method="post" name="form1" id="form2">
            <table class="table table-striped">
                <tr>
                    <td width="13%" height="40">DİL FİLTRESİ</td>
                    <td>
                        <select name="sek" id="durum5" class="form-control">
                            <option value="1" selected="selected">Kendi </option>
                            <%
sqlString = "select * from diller1 where alt = '1' ORDER BY bagli"
set mmmGenel = Con.Execute (sqlString)
Do While Not mmmGenel.EOF
                            %>
                            <option value="<%=mmmGenel("id")%>" <% if mmmGenel("id")=int(request("sek")) then%> selected="selected" <%else%> <%end if%>><%=mmmGenel("kate")%></option>
                            <%
mmmGenel.movenext
loop
close(mmmGenel)
                            %>
                        </select>
                    </td>
                    <td>
                        <input name="Submit2" type="submit" id="Submit" value="Filtrele" class="btn btn-success pull-right" style="float: left !important;" />
                        <a href="?usayi=<%=request("usayi")%>&amp;islemexcel=sayfadilexcelo&amp;git=<%=request("git")%>&amp;sek=<%=request("sek")%>" class="btn btn-danger pull-right" style="float:right !important;">Orjinali Excel</a>
              <a href="?usayi=<%=request("usayi")%>&amp;islemexcel=sayfadilexcelce&amp;git=<%=request("git")%>&amp;sek=<%=request("sek")%>" class="btn btn-danger pull-right" style="float:right !important;">Çeviriyi Excel</a>
                        <a href="?usayi=<%=request("usayi")%><%=dilsilislem %>&amp;git=<%=request("git")%>&amp;sek=<%=request("sek")%>" class="btn btn-danger pull-right" style="float: left !important;">Dil İçeriğini Sil</a>
              <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseexcel" aria-expanded="true" aria-controls="collapseexcel" class="btn-warning btn pull-right">Excel Yükle</a>

                    </td>
                </tr>
            </table>
        </form>
        <form method="post" name="Form1" id="Form1" action="?usayi=<%=request("usayi")%><%=dilduzenleislem %>&amp;git=<%=request("git")%>&amp;sek=<%=request("sek")%>" target="_self">
            <input name="charcode" type="hidden" id="charcode" value="<%=ceviridileki%>" />
            <table class="table table-striped">
                <%else %>
            <table border="1">
            <%end if %>

                <thead>
                    <th width="1%" height="40">id</th>
                    <th width="20%"><%if request.QueryString("islemexcel")="" then %>Türkçesi<%elseif request.QueryString("islemexcel")="sayfadilexcelce" then %><%else %>Orjinali<%end if %></th>
                    <th><%if request.QueryString("islemexcel")="" then %>Çevirisi<%elseif request.QueryString("islemexcel")="sayfadilexcelce" then %>Orjinali<%else %><%end if %></th>
                    <th><%if request.QueryString("islemexcel")="" then %>Soe Title<%elseif request.QueryString("islemexcel")="sayfadilexcelce" then %>Soe Title< Çevirisi<%else %><%end if %></th>
                    <th><%if request.QueryString("islemexcel")="" then %>Seo Desc<%elseif request.QueryString("islemexcel")="sayfadilexcelce" then %>Seo Desc Çevirisi<%else %><%end if %></th>
                    <th><%if request.QueryString("islemexcel")="" then %>Seolink<%elseif request.QueryString("islemexcel")="sayfadilexcelce" then %>Seolink Çevirisi<%else %><%end if %></th>
                </thead>
                <%response.Write(setchar(Request("sek"),"utf8"))
                if request.QueryString("islemexcel")="" then
                modulmuqry=" and modulmu<>'1'"
                else
                modulmuqry=" and modulmu<>'1'"
                end if%>
                <%
sqlString = "select * from kategoriyazi where dil ='240'"&sayfagosterme&" and durum='1'"&modulmuqry&" order by modulmu, anasek, sira"
set mmmGenel = Con.Execute (sqlString)
if mmmGenel.eof then%>
                <tr>
                    <td colspan="3">Ürün Kaydi Yok</td>
                </tr>
                <%else%>
                <%
Do While Not mmmGenel.EOF
iok=iok+1
if request("sek")=240 then
sqlString = "select * from kategoriyazi where dil='"&request("sek")&"' and id="&mmmGenel("id")&""
else
sqlString = "select * from kategoriyazi where dil='"&request("sek")&"' and bagli="&mmmGenel("id")&""
end if
set mmmYardimci = Con.Execute (sqlString)
                %>
                <%if request.QueryString("islemexcel")="" then %>
                <input name="haberid" type="hidden" id="haberid<%=iok%>" value="<% if mmmYardimci.eof then%>0<%else%><%=mmmYardimci("id")%><%end if%>" />
                <%end if %>

                <tr>
                    <td align="center"><%=iok%></td>
                    <td>
                        <%
sqlString = "select * from kategoriyazi where dil='240' and id="&mmmGenel("id")&" "
set mmmYardimci1= Con.Execute (sqlString)
if mmmYardimci1.eof then
else
ceviri=mmmYardimci1("isim")
                             if request.QueryString("islemexcel")="" then%>
                  <input name="durum2" type="hidden" value="<%=mmmYardimci1("id")%>" />
                <input type="text" name="durum21" id="durum21<%=iok%>" value="<%=ceviri%>" class="form-control" />
                  <%elseif request.QueryString("islemexcel")="sayfadilexcelce" then
                      else%>
                  <%=ceviri %>
                  <%end if %>
                        <%
			  
end if
close(mmmYardimci1)
if mmmYardimci.eof then
'cevvirim=yandexdilcek(ceviridil,ceviri)
'cevvirim=""
else
cvrisim=mmmYardimci("isim")   
cvrmodulmu=mmmYardimci("modulmu")                  
              
sqlString = "select * from seolar where seoid='"&mmmYardimci("id")&"' and seoturu='sayfa'"
set mmmYardimci2 = Con.Execute (sqlString)
if mmmYardimci2.eof then
smidseolar="0"
smidlang=aktifdil
smidseolink=baslikkont(syazib1)&".html"
else
smidseolar="1"
cvrstitle=mmmYardimci2("seobaslik")
cvrsdesc=mmmYardimci2("seoaciklama")
cvrsseolink=mmmYardimci2("seolink")
end if
close(mmmYardimci2)

if cvrisim="--"  then
'cevvirim=yandexdilcek(ceviridil,ceviri)
'cevvirim=cvrisim
else
cevvirim=cvrisim
end if
end if
                        %>
                    </td>
                    <td>
                        <%
                  if request.QueryString("islemexcel")="" or request.QueryString("islemexcel")="sayfadilexcelce" then %>
                    <%if request.QueryString("islemset")="sdilexcelyukla" then
                        cevvirim=split(ceviri1,"{}")(i)
                        end if
                        if request.QueryString("islemexcel")="" or (request.QueryString("islemexcel")="sayfadilexcelce" and request.QueryString("islemset")="sdilexcelyukla") then
                        
                  %>
                  <input type="text" name="haberb" id="haberb<%=iok%>" value="<%=cevvirim%>" class="form-control"/>
                  <input name="sira1" type="hidden" value="<%=mmmGenel("sira1")%>" />
                  <%else
                        response.Write(cevvirim)
                      end if %>
                  <%end if %>
                        </td>
                    <%if cvrmodulmu="1" then %>
                    <td colspan="3">
                         <% if request.QueryString("islemexcel")="" then %>
                        <input type="hidden" name="seotitle" value="" class="form-control" />
                        <input type="hidden" name="seodesc" value="" class="form-control" />
                        <input type="hidden" name="seolink" value="" class="form-control" />
                        <%end if %>
                    </td>
                    <%else %>
                    <td>
                        <% if request.QueryString("islemexcel")="" then %><input type="text" name="seotitle" id="seotitle<%=iok%>" value="<% =cvrstitle%>" class="form-control" /> <%else %><% =cvrstitle%><%end if %> </td>
                    <td>
                        <% if request.QueryString("islemexcel")="" then %><input type="text" name="seodesc" id="seodesc<%=iok%>" value="<% =cvrsdesc%>" class="form-control" /><%else %><% =cvrsdesc%><%end if %></td>
                    <td>
                         <% if request.QueryString("islemexcel")="" then %><input type="text" name="seolink" id="seolink<%=iok%>" value="<% =cvrsseolink%>" class="form-control" /><%end if %></td>
                    <%end if %>
                </tr>
                <%close(mmmYardimci)
                ceviri=""
                cevvirim=""
                cvrstitle=""
                cvrsdesc=""
                cvrsseolink=""
                cvrmodulmu=""
			  mmmGenel.MoveNext
  loop
  
                %>
                <tr>
                    <td colspan="4">
                        <%
                  if request.QueryString("islemexcel")="" then
                  %>

                        <input name="ai-addiprompt-5" id="ai-addiprompt-5" type="text" class="form-control pull-left" placeholder="Ek talimat (örn. RU, özel isimleri koru, max 60 karakter)" style=" width: 80%; ">
                        <input name="Submit" type="button" id="btnCevir" value="AI Çeviri" class="btn btn-info pull-left" />
                        <%end if %></td>
                        <td align="right"></td>
                    <td align="right">
                        <%if request.QueryString("islemexcel")="" then%>
                        <input name="Submit" type="submit" id="Submit5" value="Duzenle" class="btn btn-info pull-right" />
                        <%end if %>
                    </td>
                </tr>
                <%end if
  close(mmmGenel)%>
            </table>
 <%if request.QueryString("islemexcel")="" then %>
        </form>
</div>
</div>
<%else
    response.End
    end if%>
<%response.Write(setchar(Request("sek"),"0"))%>

<%call footer(1)%>

<script>
/* ============ yardımcılar ============ */
function qsa(sel, root=document){ return Array.from(root.querySelectorAll(sel)); }
function getValue(el){ return el?.matches?.('[contenteditable="true"]') ? (el.textContent ?? '') : (el?.value ?? ''); }
function setValue(el, val){ if(!el) return; if(el.matches?.('[contenteditable="true"]')) el.textContent = (val ?? ''); else el.value = (val ?? ''); }
function tryParseJSON(s){ try{ return JSON.parse(s); } catch{ return null; } }

/* ============ proxy (sadece {text}) ============ */
async function callProxy(task, payload){
  const res = await fetch('opt/proxy_assistant.php', {
    method:'POST', headers:{'Content-Type':'application/json'},
    body: JSON.stringify({ task, ...payload })
  });
  const data = await res.json();
  if(!res.ok) throw new Error(data?.error || 'İşlem başarısız');
  return (typeof data.result === 'string') ? data.result : JSON.stringify(data.result);
}

/* ============ satır toplama ============ */
/* Her <tr> içinde
   - kaynak: name="durum21"
   - hedef : name="haberb"
   - key   : (varsa) hidden name="durum2" | yoksa satır index */
function collectRows(root=document){
  const rows = qsa('tr', root).filter(tr =>
    tr.querySelector('[name="durum21"]') &&
    tr.querySelector('[name="haberb"]')
  );
  return rows.map((tr, idx) => {
    const keyEl = tr.querySelector('input[name="durum2"]');
    const key   = (keyEl && getValue(keyEl).trim()) || String(idx);
    const srcEl = tr.querySelector('input[name="durum21"], textarea[name="durum21"], [contenteditable="true"][name="durum21"]');
    const dstEl = tr.querySelector('input[name="haberb"], textarea[name="haberb"], [contenteditable="true"][name="haberb"]');
    return { tr, key, srcEl, dstEl };
  });
}

/* ============ ana akış (tek metin payload) ============ */
async function translateTableDurum21ToHaberb({
  root = document,
  overwrite = true,
  extraPromptElId = 'ai-addiprompt-5',
  taskName = 'translate_text'
} = {}) {

  // 1) kaynakları topla (boşları gönderme)
  const rows = collectRows(root);
  const sourceMap = {};
  const rowByKey = new Map();
  rows.forEach(r => {
    rowByKey.set(r.key, r);
    console.log(r);
    const v = (getValue(r.srcEl) || '').trim();
    if (v !== '') sourceMap[r.key] = v;
  });

  const keys = Object.keys(sourceMap);
  if (keys.length === 0){
    console.warn('Çevrilecek dolu "durum21" metni yok.');
    return;
  }

  // 2) ekstra serbest prompt (hedef dil, ton, vb.)
  const extraEl = document.getElementById(extraPromptElId);
  const extra   = extraEl && extraEl.value.trim() ? extraEl.value.trim() : '';

  // 3) TEK METİN — talimat + (opsiyonel) ek talimat + kaynak JSON + beklenen çıktı şeması
  const sample1 = keys[0] || '1410';
  const sample2 = keys[1] || '1411';

  const text =
`[GÖREV]
"Kaynak" bölümündeki değerleri ek talimatta belirtilen hedef dile çevirin.
Anahtarlar satır kimlikleridir; AYNEN korunmalıdır.
Yeni anahtar eklemeyin, mevcut anahtarları silmeyin veya yeniden adlandırmayın.
Boş metinleri boş bırakın. Biçimlendirme/HTML varsa koruyun; yoksa düz metin üretin.

${extra ? `[EK TALİMAT]\n${extra}\n` : ''}[BEKLENEN ÇIKTI]
YALNIZCA geçerli JSON döndürün; açıklama/markdown/kod bloğu eklemeyin.

{ "translations": { "<key>": "<çeviri>" } }

Örnek:
{
  "translations": {
    "${sample1}": "Translated text 1",
    "${sample2}": "Translated text 2"
  }
}

[KAYNAK]
Aşağıdaki JSON’daki değerleri çevirin; anahtarları aynen koruyun:
${JSON.stringify(sourceMap, null, 2)}
`;

//console.log({ text });
//exit;

  // 4) proxy çağrısı: sadece { text }
  const raw = await callProxy(taskName, { text });

  // 5) yanıtı çöz ve yaz
  const parsed = tryParseJSON(raw);
  let translations = {};
  if (parsed && typeof parsed === 'object') {
    translations = (parsed.translations && typeof parsed.translations === 'object')
      ? parsed.translations
      : parsed; // düz dönerse kabul
  }

  // sadece mevcut anahtarlar ve string değerler
  const safe = {};
  for (const k of keys){
    if (!Object.prototype.hasOwnProperty.call(translations, k)) continue;
    const v = translations[k];
    if (typeof v === 'string') safe[k] = v;
  }

  // hedef alanlara yaz
  Object.entries(safe).forEach(([k, textVal]) => {
    const r = rowByKey.get(k);
    if (!r || !r.dstEl) return;
    if (overwrite || (getValue(r.dstEl).trim() === '')) {
      setValue(r.dstEl, textVal);
    }
  });

  console.log('Gönderilen key sayısı:', keys.length);
  console.log('Yazılan çeviriler:', safe);
}

/* ============ buton ============ */
document.getElementById('btnCevir')?.addEventListener('click', () => {
     this.disabled=false;
  translateTableDurum21ToHaberb({
    overwrite: true,
    extraPromptElId: 'ai-addiprompt-5',
    taskName: 'translate_text'
  });
});
</script>

