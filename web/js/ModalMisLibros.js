document.getElementById('btnLibReservados').addEventListener('click', function(){
  document.getElementById('librosReservados').style.display = 'block';
  document.getElementById('librosPrestados').style.display = 'none';
});

document.getElementById('btnLibPrestados').addEventListener('click', function(){
  document.getElementById('librosReservados').style.display = 'none';
  document.getElementById('librosPrestados').style.display = 'block';
});

