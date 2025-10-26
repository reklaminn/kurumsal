let priceData = {}; // API'den çekilen fiyat verileri
    let fullPriceData = []; // Ana JSON'u saklamak için
  

    $(function() {
     

    
      $("#newdepdate1").datepicker({
      //numberOfMonths: getNumberOfMonths(),
      beforeShowDay: function(date) {
        let formattedDate = formatDate(date);
        return priceData[formattedDate] ? [true, "available", `$${priceData[formattedDate]}`] : [false, "unavailable", ""];
      },
      beforeShow: function(input, inst) {
        setTimeout(() => addCustomInformation1(), 50);
    },    
      onChangeMonthYear: function(year, month, inst) {
        //console.log("Ay Değiştirildi:", year, month);
    
        setTimeout(() => {
            $("#newdepdate").datepicker("refresh"); // Takvimi yenile
            setTimeout(() => addCustomInformation1(), 200);
        }, 100);
      },
      onSelect: function(dateText, inst) {
        console.log("Seçilen Tarih:", dateText);
    
        if (!inst.selectedYear || !inst.selectedMonth || !inst.selectedDay) {
            console.error("Eksik tarih bilgisi:", inst);
            return false;
        }
    
        let cleanDay = inst.selectedDay.toString().replace(/<[^>]+>/g, "").trim();
        let day = parseInt(cleanDay, 10);
        let month = parseInt(inst.selectedMonth, 10);
        let year = parseInt(inst.selectedYear, 10);
    
        if (isNaN(day) || isNaN(month) || isNaN(year)) {
            console.error("Geçersiz Tarih:", { day, month, year });
            return false;
        }
    
        let formattedDate = formatDate(new Date(year, month, day));
        selectedDate = fullPriceData.find(item => item.value === formattedDate) || null;
    
        if (!selectedDate) {
            console.error("Seçilen tarihe ait JSON bulunamadı:", formattedDate);
            return false;
        }
    
        //console.log("Seçilen JSON:", selectedDate);
        //updateCabinGrid(selectedDate);
        //updateResultMessage();
        setTimeout(() => addCustomInformation1(), 100);
        let cabinGrid = document.getElementById("cabin-grid");
        if (cabinGrid) {
            let offset = cabinGrid.getBoundingClientRect().top + window.scrollY - 170;
            window.scrollTo({ top: offset, behavior: "smooth" });
        }
      }
    });
    setTimeout(addCustomInformation1, 10); // Sayfa yüklendiğinde fiyatları göster
});  
    function addCustomInformation1() {
      //console.log("Fiyat Bilgileri Yenileniyor...");
    
      $("#ui-datepicker-div .ui-datepicker-calendar td").each(function () {
        let dateText = $(this).find("a").text().replace(/<[^>]+>/g, "").trim();

        //let dateText = $(this).find("a").clone().find("span").remove().end().text().trim();
    
        if (!dateText) return;
    
        let cell = $(this);
        let selectedMonth = parseInt(cell.attr("data-month"));
        let selectedYear = parseInt(cell.attr("data-year"));
    
        if (isNaN(selectedMonth) || isNaN(selectedYear)) {
          let parentCalendar = $("#ui-datepicker-div");
          selectedYear = parseInt(parentCalendar.find(".ui-datepicker-year").first().text().trim(), 10);
          selectedMonth = parentCalendar.find(".ui-datepicker-month").first().text().trim();
          selectedMonth = new Date(Date.parse(selectedMonth + " 1, " + selectedYear)).getMonth();
        }
    
        let selectedDate = new Date(selectedYear, selectedMonth, parseInt(dateText));
        let formattedDate = formatDate(selectedDate);
        console.log(selectedDate);
        console.log(formattedDate);
    
        if (priceData[formattedDate]) {
  // Önce var olan HTML içeriğini temizleyerek yalnızca gün numarasını bırakıyoruz.
  let dayNumber = $(this).find("a").text().replace(/<[^>]+>/g, "").trim();
        //let dayNumber = $(this).find("a").clone().find("span").remove().end().text().trim();

  // HTML'e yeni bir fiyat etiketi ekleyelim
  $(this).find("a").html(`${dayNumber}`);

  // Fiyatı ayrı bir <span> etiketi ile ekleyelim
  $(this).append(`<span class="price-tag">$${priceData[formattedDate]}</span>`);
  //$(this).find("a").append(`<span class="price-tag">$${priceData[formattedDate]}</span>`);
}

      });
    }
    

    let allPriceData = {}; // Tüm tarihleri içeren ana nesne
    let apiLoaded = false; // API'nin yüklendiğini takip eder
    
    $(function() {
        
        function getTomorrowFormatted() {
            let today = new Date();
            let tomorrow = new Date(today);
            tomorrow.setDate(today.getDate() + 1); // Yarına ayarla
    
            // 📌 "Saturday, Feb 22, 2025" formatında tarih döndür
            let options = { weekday: 'long', month: 'short', day: 'numeric', year: 'numeric' };
            return tomorrow.toLocaleDateString('en-US', options);
        }
        
        $("#newdepdate").datepicker({
            dateFormat: "DD, M d, yy",
            beforeShowDay: function(date) {
                let formattedDate = formatDate(date);
                return priceData[formattedDate] ? [true, "available", `$${priceData[formattedDate]}`] : [false, "unavailable", ""];
            },
            beforeShow: function(input, inst) {
              
                    setTimeout(() => addCustomInformation(), 50);
           
            },
            onChangeMonthYear: function(year, month, inst) {
              
                setTimeout(() => addCustomInformation(), 50);
                
            },
            onSelect: function(dateText, inst) {

                if (!inst.selectedYear || !inst.selectedMonth || !inst.selectedDay) {
                    console.error("Eksik tarih bilgisi:", inst);
                    return false;
                }
            
                let cleanDay = inst.selectedDay.toString().replace(/<[^>]+>/g, "").trim();
                let day = parseInt(cleanDay, 10);
                let month = parseInt(inst.selectedMonth, 10);
                let year = parseInt(inst.selectedYear, 10);
            
                if (isNaN(day) || isNaN(month) || isNaN(year)) {
                    console.error("Geçersiz Tarih:", { day, month, year });
                    return false;
                }
            
                let formattedDate = formatDate(new Date(year, month, day));
                selectedDate = fullPriceData.find(item => item.value === formattedDate) || null;


                    // 📌 Eğer `value` yoksa, tarih aralıklarını kontrol ediyoruz
                    if (!selectedDate) {
                        selectedDate = fullPriceData.find(item => 
                            item.start_date && item.end_date &&
                            formattedDate >= formatDate(new Date(item.start_date)) &&
                            formattedDate <= formatDate(new Date(item.end_date))
                        );
}
                updateCabinGrid(selectedDate);
                updateResultMessage();
                setTimeout(() => addCustomInformation(), 100);
                let cabinGrid = document.getElementById("cabin-grid");
                if (cabinGrid) {
                    let offset = cabinGrid.getBoundingClientRect().top + window.scrollY - 170;
                    window.scrollTo({ top: offset, behavior: "smooth" });
                }

            }
        });
        let tomorrowFormatted = getTomorrowFormatted();
        $("#newdepdate").attr("placeholder", tomorrowFormatted);
   // $("#newdepdate").datepicker("setDate", tomorrowFormatted);
    });
    
    // 📌 **API’den Gelen Veriyi JavaScript’te Ayırma**
    function processData(data) {
        data.forEach(item => {
            let startDate = new Date(item.start_date);
            let endDate = new Date(item.end_date);
    
            let minPrice = findMinPrice(item.cabins);
    
            while (startDate <= endDate) {
                let formattedDate = formatDate(startDate);
                let yearMonth = `${startDate.getFullYear()}-${startDate.getMonth()}`; // "2025-2" formatında
    
                if (!allPriceData[yearMonth]) {
                    allPriceData[yearMonth] = {}; // Bu ay için yeni bir nesne oluştur
                }
    
                allPriceData[yearMonth][formattedDate] = minPrice;
                startDate.setDate(startDate.getDate() + 1);
            }
        });
    }
    
    // 📌 **Görünür Ayın Verisini `priceData` İçine Aktarma**
    function loadMonthData(year, month) {
        let yearMonth = `${year}-${month}`; // "2025-2" formatında
    
        // Eğer o ayın verisi varsa, `priceData` içine aktar
        if (allPriceData[yearMonth]) {
            priceData = { ...allPriceData[yearMonth] }; // Objeyi klonla
        } else {
            priceData = {}; // O ay için veri yoksa boş bırak
        }
    
        $("#newdepdate").datepicker("refresh");
        setTimeout(addCustomInformation, 100);
    }
    
    // 📌 **Takvimde Günlere Fiyat Ekle**
    function addCustomInformation() {
        $("#ui-datepicker-div .ui-datepicker-calendar td").each(function () {
            let dateText = $(this).find("a").clone().find("span").remove().end().text().trim();
            if (!dateText) return;
    
            let cell = $(this);
            let selectedMonth = parseInt(cell.attr("data-month"));
            let selectedYear = parseInt(cell.attr("data-year"));
    
            let selectedDate = new Date(selectedYear, selectedMonth, parseInt(dateText));
            let formattedDate = formatDate(selectedDate);
    
            if (priceData[formattedDate]) {
                let dayNumber = $(this).find("a").clone().find("span").remove().end().text().trim();
                $(this).find("a").html(`${dayNumber}`);
                $(this).append(`<span class="price-tag">$${priceData[formattedDate]}</span>`);
                //$(this).find("a").append(`<span class="price-tag">$${priceData[formattedDate]}</span>`);
            }
        });
    }
    
    // 📌 **Yardımcı Fonksiyonlar**
    function findMinPrice(cabins) {
        let prices = [];
        Object.values(cabins).forEach(cabin => {
            Object.values(cabin).forEach(price => {
                if (typeof price === "number") prices.push(price);
            });
        });
        return prices.length > 0 ? Math.min(...prices) : "-";
    }
    
 
    



function getNumberOfMonths() {
    let screenWidth = window.innerWidth;

    if (screenWidth >= 1200) { // Büyük ekran (Masaüstü, Laptop)
        return 3;
    } else if (screenWidth >= 768) { // Orta boyutlu ekran (Tablet)
        return 2;
    } else { // Küçük ekran (Telefon)
        return 1;
    }
}


function formatDate(date) {
  return date.toISOString().split('T')[0];
}

function formatDateString(dateString) {
  return formatDate(new Date(dateString));
}




const dateContainer = document.getElementById('date-container');
const cabinGrid = document.getElementById('cabin-grid');
const resultDiv = document.getElementById('result');
const resultDiv1 = document.getElementById('result1');
const reservationButton = document.getElementById('reservation-button');

let selectedDate = null;
let selectedCabins = {};
let globalCabinTemplate = null;
let globalDateTemplate = null;
let globalResultTemplate = null;

if (reservationButton) {
// Şablonları ve verileri getirme
async function fetchTemplates() {
    try {
        const response = await fetch(`${window.location.origin}/api?type=templates`);
        if (!response.ok) throw new Error(`Failed to fetch templates: ${response.status}`);
        const templates = await response.json();

        globalResultTemplate = templates.resultTemplate;
        globalCabinTemplate = templates.cabinTemplate;
        globalDateTemplate = templates.dateTemplate;

        fetchData();
    } catch (error) {
        console.error("Error fetching templates:", error);
    }
}

async function fetchData() {
    try {
        let apiUrl = `${window.location.origin}/api?type=cruise-data`;
    // API'den JSON verisini çek
    $.getJSON(apiUrl, function(data) {
        console.log("API Yanıtı:", data); // API'den dönen JSON'u konsola yazdıralım
    
        // API yanıtının doğruluğunu kontrol et
        if (!data || !Array.isArray(data.dates)) {
            console.error("API Yanıtı Geçersiz: `dates` alanı eksik veya yanlış formatta.");
            return;
        }
    
        fullPriceData = data.dates; // Tüm JSON verisini sakla
    
        data.dates.forEach(item => {
            let minPrice = findMinPrice(item.cabins); // En düşük fiyatı hesapla
    
            if (item.start_date && item.end_date) {
                let startDate = new Date(item.start_date);
                let endDate = new Date(item.end_date);
    
                while (startDate <= endDate) {
                    let formattedDate = formatDate(startDate);
                    priceData[formattedDate] = minPrice;
                    startDate.setDate(startDate.getDate() + 1);
                }
            } else if (item.value) {
                let formattedDate = formatDateString(item.value);
                priceData[formattedDate] = minPrice;
            }
        });
    
        $("#newdepdate").datepicker("refresh");
        setTimeout(addCustomInformation1, 10);
    }).fail(function(jqXHR, textStatus, errorThrown) {
        console.error("API'den fiyat verisi alınamadı!", textStatus, errorThrown);
    });
    } catch (error) {
        console.error("Error fetching data:", error);
        alert("Failed to load cruise data. Please try again later.");
    }
}


// Kabin seçimlerini doldurma
function updateCabinGrid(date) {
    cabinGrid.innerHTML = '';
    selectedCabins = date.cabins;

    const cabinTypes = Object.keys(selectedCabins);

    if (cabinTypes.length === 1) {
        // 📌 Sadece 1 kabin varsa otomatik seç, gizle ve hesaplamayı başlat
        const cabinType = cabinTypes[0]; 
        const lowestPrice = selectedCabins[cabinType].adult;
        const description = `Comfortable ${cabinType} cabin`;

        const cabinHtml = globalCabinTemplate
            .replace('{{cabinName}}', capitalize(cabinType))
            .replace('{{description}}', description)
            .replace('{{lowestPrice}}', `€${lowestPrice}`);

        const cabinElement = document.createElement('div');
        cabinElement.innerHTML = cabinHtml;
        const cabinItem = cabinElement.firstChild; 

        cabinItem.dataset.value = cabinType;
        cabinItem.classList.add('active'); 

        // 📌 Kabini gizle
        cabinItem.style.display = 'none';

        // 📌 Hesaplamayı hemen yap
        updateResultMessage();

        cabinGrid.appendChild(cabinItem);
        return;
    }

    cabinTypes.forEach(cabinType => {
        const lowestPrice = selectedCabins[cabinType].adult;
        const description = ` ${cabinType} `;

        const cabinHtml = globalCabinTemplate
            .replace('{{cabinName}}', capitalize(cabinType))
            .replace('{{description}}', description)
            .replace('{{lowestPrice}}', `€${lowestPrice}`);

        const cabinElement = document.createElement('div');
        cabinElement.innerHTML = cabinHtml;

        const cabinItem = cabinElement.firstChild; // cabin-item öğesi
        cabinItem.dataset.value = cabinType; // data-value özelliği ayarlandı
        // 📌 Sayfa yenilenmesini önlemek için event listener'da preventDefault kullanıyoruz
        cabinItem.addEventListener('click', (event) => {
            console.log("1");
            event.preventDefault(); // 🚀 Sayfa yenilenmesini engeller
            event.stopPropagation(); // 🚀 Fazladan event propagation'ı engeller

            document.querySelectorAll('.cabin-item').forEach(item => item.classList.remove('active'));
            cabinItem.classList.add('active');

            console.log("2");

            updateResultMessage();
        });

        console.log("3");
        cabinGrid.appendChild(cabinItem);
    });
}

// Sonuç mesajını güncelleme
function updateResultMessage() {

    console.log("4");
    const selectedCabinButton = document.querySelector('.cabin-item.active');
    console.log(selectedCabinButton);
    if (!selectedCabinButton) {
        resultDiv.innerHTML = '<div class="alert alert-primary" role="alert"><p class="text-light">Please Select Date.</p></div>';
        resultDiv1.innerHTML = '<div class="alert alert-primary" role="alert"><p class="text-light">Please Select Date.</p></div>';
        return;
    }

    const selectedCabinType = selectedCabinButton.closest('.cabin-item')?.dataset?.value;
console.log(selectedCabinType);
    if (!selectedCabinType) {
        resultDiv.innerHTML = '<div class="alert alert-primary" role="alert"><p class="text-light">Please Select Date.</p></div>';
        resultDiv1.innerHTML = '<div class="alert alert-primary" role="alert"><p class="text-light">Please Select Date.</p></div>';
        return;
    }
    const { totalCost, priceIssues } = calculateTotalCost(selectedCabinType);
  
console.log(priceIssues);
    if (priceIssues.length > 0) {
        resultDiv.innerHTML = `
            <div class="alert alert-primary" role="alert"><p>Total Cost: <strong>Ask for Price</strong></p>
            <p>Note: Price not available for ${priceIssues.join(', ')}.</p></div>
        `;
        resultDiv1.innerHTML = `
            <div class="alert alert-primary" role="alert"><p>Total Cost: <strong>Ask for Price</strong></p>
            <p>Note: Price not available for ${priceIssues.join(', ')}.</p></div>
        `;
    } else {
        resultDiv.innerHTML = globalResultTemplate.replace('{{totalCost}}', totalCost.toFixed(2));
        resultDiv1.innerHTML = globalResultTemplate.replace('{{totalCost}}', totalCost.toFixed(2));
        document.getElementById("totalprice").value = totalCost.toFixed(2);

}

// Toplam maliyeti hesaplama
function calculateTotalCost(selectedCabinType) {
    console.log("calculateTotalCost");
    const cabinPrices = selectedCabins[selectedCabinType];
    console.log(cabinPrices);
    const adults = parseInt(document.getElementById('adults').value) || 0;
    const children_12_17 = parseInt(document.getElementById('children_12_17').value) || 0;
    const children_2_11 = parseInt(document.getElementById('children_2_11').value) || 0;
    const infants = parseInt(document.getElementById('infants').value) || 0;

    let totalCost = 0;
    const priceIssues = [];

    if (adults > 0) {
        if (typeof cabinPrices.adult === 'number') {
            totalCost += adults * cabinPrices.adult;
        } else {
            priceIssues.push('Adults (18+)');
        }
    }

    if (children_12_17 > 0) {
        if (typeof cabinPrices.child_12_17 === 'number') {
            totalCost += children_12_17 * cabinPrices.child_12_17;
        } else {
            priceIssues.push('Children (12-17)');
        }
    }

    if (children_2_11 > 0) {
        if (typeof cabinPrices.child_2_11 === 'number') {
            totalCost += children_2_11 * cabinPrices.child_2_11;
        } else {
            priceIssues.push('Children (2-11)');
        }
    }

    if (infants > 0) {
        if (typeof cabinPrices.infant === 'number') {
            totalCost += infants * cabinPrices.infant;
        } else {
            priceIssues.push('Infants (0-1)');
        }
    }

    return {
        totalCost: priceIssues.length > 0 ? null : totalCost,
        priceIssues,
    };
}

// Yolcu sayısı arttırma/azaltma
function increment(id) {
    const input = document.getElementById(id);
    input.value = parseInt(input.value) + 1;
    updateResultMessage();
}

function decrement(id) {
    const input = document.getElementById(id);
    if (parseInt(input.value) > parseInt(input.min)) {
        input.value = parseInt(input.value) - 1;
        updateResultMessage();
    }
}


// Rezervasyon butonu
reservationButton.addEventListener('click', () => {
    if (!selectedDate || Object.keys(selectedCabins).length === 0) {
        alert('Please Select Date for Reservation');
        return;
    }

    const selectedCabinType = document.querySelector('.cabin-item .btn.active')?.closest('.cabin-item')?.dataset?.value;
    const reservationData = {
        date: selectedDate.value,
        cabinType: selectedCabinType,
        passengers: {
            adults: parseInt(document.getElementById('adults').value) || 0,
            children_12_17: parseInt(document.getElementById('children_12_17').value) || 0,
            children_2_11: parseInt(document.getElementById('children_2_11').value) || 0,
            infants: parseInt(document.getElementById('infants').value) || 0
        },
        totalCost: calculateTotalCost(selectedCabinType).totalCost,
    };

    sessionStorage.setItem('reservationData', JSON.stringify(reservationData));
    window.location.href = 'reservation.html';
});

// Yardımcı fonksiyonlar
function capitalize(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
}// Şablonları yükle
fetchTemplates();
}