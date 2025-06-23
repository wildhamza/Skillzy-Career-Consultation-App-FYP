const deleteAccount = async (email,otp) => {
  try {
    const { response: res } = await axios({
      method: "POST",
      url: "/api/v1/auth/delete-account-confirmation",
      data: { email,otp },
    })
    const params = new URLSearchParams(window.location.search);
    // url = params.get("redirect")
    window.location.href = window.location.origin +  "/" + "delete-sucessfully";

  } catch (err) {
    console.log(err.response.data)
  }
}

document.querySelector("#login").addEventListener("submit", e => {
  e.preventDefault();
  const formData = new FormData(e.target);
  const [email,otp] = [formData.get("email"),formData.get("otp")];
  console.log(email,otp);
  deleteAccount(email,otp)
})