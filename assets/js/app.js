// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
// import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

const editButtons = document.getElementsByClassName("starred-repo-edit-btn");
for(const btn of editButtons) {
  btn.onclick = function(e) {
    const repoNameHolder = document.getElementById("modal-starred-repo-name");
    const hiddenRepoIdInputField = document.getElementById("starred-repo-id");
    const tagsInputField = document.getElementById("repo-tags-input");
    const alertDiv = document.getElementById("tags-modal-alert");
    let repoName = e.target.dataset.starredRepoName;
    let repoId = e.target.dataset.starredRepoId;
    let repoTags = e.target.dataset.starredRepoTags;
    // hide the alert div
    alertDiv.style.display = "none";
    // set repo name in the heading
    repoNameHolder.innerHTML = repoName;

    //set repo id in hidden input field
    hiddenRepoIdInputField.value = repoId;

    //populate tag inputs
    tagsInputField.value = repoTags;
  };
};

const saveTagBtn = document.getElementById("save-tags");
saveTagBtn.onclick = async function(e) {
  e.preventDefault();
  const hiddenRepoIdInputField = document.getElementById("starred-repo-id");
  const tagsInputField = document.getElementById("repo-tags-input");
  const alertDiv = document.getElementById("tags-modal-alert");
  let json = await apiReq.json();
  let apiReq = await fetch('starred_repos/' + hiddenRepoIdInputField.value, {
    method: 'PUT',
    headers: {
      'x-csrf-token': document.querySelector('meta[name="csrf-token"]').content,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({tags: tagsInputField.value})
  })

  alertDiv.className = "alert";
  if(apiReq.ok) {
    alertDiv.className += " alert-success";
    alertDiv.style.display = "block";
    alertDiv.innerText = json.message;
  } else{
    alertDiv.className += " alert-danger";
    alertDiv.style.display = "block";
    alertDiv.innerText = json.message;
  }
}