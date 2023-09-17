import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const avatarInput = document.getElementById('article_avatar');
    const imagesInput = document.getElementById('article_images');
    // const promotionalVideoInput = document.getElementById('article_promotional_video');

    avatarInput.addEventListener('change', () => {
      const fileName = avatarInput.value.split(/(\\|\/)/g).pop();
      document.getElementById('avatar_name').innerHTML = fileName;
    });

    imagesInput.addEventListener('change', () => {
      document.getElementById('images_name').innerHTML = `${imagesInput.files.length} imagen(es) adjunto(s)`;
    });

    // promotionalVideoInput.addEventListener('change', () => {
    //   const fileName = promotionalVideoInput.value.split(/(\\|\/)/g).pop();
    //   document.getElementById('promotional_video_name').innerHTML = fileName;
    // });
  }

  addAvatar() {
    document.getElementById('article_avatar').click();
  }

  addImages() {
    document.getElementById('article_images').click();
  }

  addPromotionalVideo() {
    document.getElementById('article_promotional_video').click();
  }
}
