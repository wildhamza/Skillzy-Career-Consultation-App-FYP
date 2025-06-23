const login = async (email) => {
  try {
    const { response: res } = await axios({
      method: "POST",
      url: "/api/v1/auth/delete-account",
      data: { email },
    })
    // url = params.get("redirect")
    alert("Please check your email or spam folder.");
    window.location.href = window.location.origin +  "/" + "delete-my-data";

  } catch (err) {
    alert("Please  enter a valid email");
  }
}

document.querySelector("#login").addEventListener("submit", e => {
  e.preventDefault();
  const formData = new FormData(e.target);
  const [email] = [formData.get("email")];
  console.log(email);
  login(email)
})
