// Login.tsx
import React, { useState } from "react";
import Axios from "axios";
import { Link, useNavigate } from "react-router-dom";
import { useUser } from "../../context/UserContext";
import { FaUserShield } from "react-icons/fa";
import { AiOutlineSwapRight } from "react-icons/ai";
import { BsFillShieldLockFill } from "react-icons/bs";
import video from "../../assets/video.mp4";
import logo from "../../assets/logo.png";
import "./Login.scss";
import "../../styles/authentication.scss";

const LogIn: React.FC = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loginStatus, setLoginStatus] = useState("");
  const navigate = useNavigate();
  const { login } = useUser();

  const logInUser = async () => {
    try {
      const response = await Axios.post("http://127.0.0.1:4500/api/gym/login", {
        gym_name: email,
        gym_password: password,
      });

      if (response.status === 200) {
        console.error(response.data.data);
        setLoginStatus("Login successful");
        login(response.data.data); // Call login with the GymData object
        navigate("/");
      } else {
        setLoginStatus("Login failed");
      }
    } catch (error) {
      console.error(error);
      setLoginStatus("Login error");
    }
  };

  return (
    <div className="loginPage flex">
      <div className="container flex">
        <div className="videoDiv">
          <video src={video} autoPlay muted loop></video>
          <div className="textDiv">
            <h2 className="title">Create And Get User</h2>
            <p>Adopt the peace of nature!</p>
          </div>
          <div className="footerDiv flex">
            <span className="text">Don't have an account</span>
            <Link to="/register">
              <button className="btn">Sign UP</button>
            </Link>
          </div>
        </div>
        <div className="formDiv flex">
          <div className="headerDiv">
            <img src={logo} alt="" />
            <h3>Welcome Back!</h3>
          </div>
          <form action="" className="form grid">
            {loginStatus && <span className="showMessage">{loginStatus}</span>}
            <div className="inputDiv">
              <label htmlFor="username">Username</label>
              <div className="input flex">
                <FaUserShield className="icon" />
                <input
                  type="text"
                  id="username"
                  placeholder="Enter Username"
                  onChange={(event) => {
                    setEmail(event.target.value);
                  }}
                />
              </div>
            </div>
            <div className="inputDiv">
              <label htmlFor="password">Password</label>
              <div className="input flex">
                <BsFillShieldLockFill className="icon" />
                <input
                  type="password"
                  id="password"
                  placeholder="Enter Password"
                  onChange={(event) => {
                    setPassword(event.target.value);
                  }}
                />
              </div>
            </div>
            <button type="button" className="btn flex" onClick={logInUser}>
              <span>Login</span>
              <AiOutlineSwapRight className="icon" />
            </button>
            <span className="forgotPassword">
              Forgot your password?<a href="">Click Here</a>
            </span>
          </form>
        </div>
      </div>
    </div>
  );
};

export default LogIn;
