// var dropdown = document.getElementsByClassName("dropdown");
// // dropdown.forEach(
// // 	element => element.addEventListener("click", function() {
// // 	console.log("button clicked");
// // 	element.classList.toggle("is-active");
// // }))
// console.log(dropdown);
// for (var i = 0; i < dropdown.length; i++) {
// 	dropdown[i].addEventListener("click", function(el) {
// 	console.log("button clicked");
// 	console.log(el.dataset);
// 	dropdown[i].classList.toggle("is-active");
// })
// }


const drops = Array.prototype.slice.call(document.querySelectorAll('.dropdown'), 0);
  if (drops.length > 0) {
    drops.forEach( el => {
      el.addEventListener('click', () => {
        const target = el.dataset.target;
        // const $target = document.getElementById(target);
        el.classList.toggle('is-active');
        // $target.classList.toggle('is-active');

      });
    });
  }
