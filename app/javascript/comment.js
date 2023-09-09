document.addEventListener('DOMContentLoaded', function() {
  const editButton = document.querySelector('.btn-edit');
  if (editButton) {
    editButton.addEventListener('click', toggleEditMode);
  }
});

function toggleEditMode() {
  document.getElementById('edit-comment-form').style.display = 'block';
  document.querySelectorAll('.view-mode').forEach(el => el.style.display = 'none');
}
