import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profiles"
export default class extends Controller {
  connect() {
    const avatarInput = document.getElementById('profile_avatar');

    avatarInput.addEventListener('change', () => {
      const fileName = avatarInput.value.split(/(\\|\/)/g).pop();
      document.getElementById('avatar_name').innerHTML = fileName;
    });
  }

  addAvatar() {
    document.getElementById('profile_avatar').click();
  }
}
