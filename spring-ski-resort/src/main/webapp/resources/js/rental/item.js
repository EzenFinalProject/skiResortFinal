let lowItem = document.getElementById('lowItem');
let midItem = document.getElementById('midItem');
let premiumItem = document.getElementById('premiumItem');

lowItem.addEventListener('click', () => {
     document.getElementById('lowItemImageBox').style.display = 'flex';
     document.getElementById('midItemImageBox').style.display = 'none';
     document.getElementById('premiumItemImageBox').style.display = 'none';
     document.getElementById('lowItemTextBox').style.display = 'flex';
     document.getElementById('midItemTextBox').style.display = 'none';
     document.getElementById('premiumItemTextBox').style.display = 'none';
})
midItem.addEventListener('click', () => {
     document.getElementById('lowItemImageBox').style.display = 'none';
     document.getElementById('midItemImageBox').style.display = 'flex';
     document.getElementById('premiumItemImageBox').style.display = 'none';
     document.getElementById('lowItemTextBox').style.display = 'none';
     document.getElementById('midItemTextBox').style.display = 'flex';
     document.getElementById('premiumItemTextBox').style.display = 'none';
})
premiumItem.addEventListener('click', () => {
     document.getElementById('lowItemImageBox').style.display = 'none';
     document.getElementById('midItemImageBox').style.display = 'none';
     document.getElementById('premiumItemImageBox').style.display = 'flex';
     document.getElementById('lowItemTextBox').style.display = 'none';
     document.getElementById('midItemTextBox').style.display = 'none';
     document.getElementById('premiumItemTextBox').style.display = 'flex';
})



let page = 0; // 현재 인덱스 번호
let imageWidth = 400; // 이미지 width

let value = 0;
let rigthWidth = 500;
let leftWidth = 500;

let nextBtn = document.getElementById('slideNextBtn'); // 다음 이미지로 넘어가는 버튼
let prevBtn = document.getElementById('slidePrevBtn'); // 다음 이미지로 넘어가는 버튼

function next() {
     if (value == -5500) {
          return;
     }

     value -= rigthWidth;
     console.log("오른쪽버튼" + value);

     let lowItemImage = document.getElementById('lowItemImageBox');
     lowItemImage.style.transition = 'transform 0.8s ease';
     lowItemImage.style.transform = 'translateX(' + value + 'px)';

     let midItemImage = document.getElementById('midItemImageBox');
     midItemImage.style.transition = 'transform 0.8s ease';
     midItemImage.style.transform = 'translateX(' + value + 'px)';

     let premiumItemImage = document.getElementById('premiumItemImageBox');
     premiumItemImage.style.transition = 'transform 0.8s ease';
     premiumItemImage.style.transform = 'translateX(' + value + 'px)';
}

function prev() {
     if (value == 0) {
          return;
     }


     value += leftWidth;
     console.log("왼쪽버튼" + value);

     let lowItemImage = document.getElementById('lowItemImageBox');
     lowItemImage.style.transition = 'transform 0.8s ease';
     lowItemImage.style.transform = 'translateX(' + value + 'px)';

     let midItemImage = document.getElementById('midItemImageBox');
     midItemImage.style.transition = 'transform 0.8s ease';
     midItemImage.style.transform = 'translateX(' + value + 'px)';

     let premiumItemImage = document.getElementById('premiumItemImageBox');
     premiumItemImage.style.transition = 'transform 0.8s ease';
     premiumItemImage.style.transform = 'translateX(' + value + 'px)';
}

if (nextBtn) {
     nextBtn.addEventListener('click', function () {
          next();
     });
}
if (prevBtn) {
     prevBtn.addEventListener('click', function () {
          prev();
     });
}
