var slides = [
  '00-title.html',
  '01-introduction.html',
  '02-installation.html',
  '03-game_loop.html',
  '04-event_handler.html',
  '05-move_handler.html',
  '06-show_handler.html',
  '07-game_state.html',
  '08-paddle.html',
  '09-blocks.html',
  '10-ball.html',
  '11-key_events.html',
  '12-other_events.html',
  '13-move_paddle.html',
  '14-move_ball_plan.html',
  '15-move_ball.html',
  '16-move_ball_2.html',
  '17-draw_primitives_fig.html',
  '18-draw_primitives.html',
  '19-draw_sprites_fig.html',
  '20-draw_sprites.html',
  '21-sound_effects.html',
  '22-music.html',
  '23-questions.html'
];

function loadSlide(slide) {
  if (slide >= 0 && slide <= 23) {
    window.location.href = slides[slide];
  }
}

var currentSlide = parseInt(window.location.href.match(/(\d+)-\w+.html/)[1], 10);
console.log('Current slide is: ' + currentSlide);

document.onkeydown = function(e) {
  if (e.keyCode == 38) {
    loadSlide(currentSlide - 1);
  } else if (e.keyCode == 40) {
    loadSlide(currentSlide + 1);
  }
}


