// Register.tsx
import React, { useState } from "react";
import Axios from "axios";
import { Link, useNavigate } from "react-router-dom";
import { useUser } from "../../context/UserContext";
import { FaDumbbell } from "react-icons/fa";
import video from "../../assets/video.mp4";
import logo from "../../assets/logo.png";
import "./Register.scss";
import "../../styles/authentication.scss";

const RegisterGym: React.FC = () => {
  const [gymName, setGymName] = useState("");
  const [gymPassword, setGymPassword] = useState("");
  const [location, setLocation] = useState("");
  const [monthlyPayment, setMonthlyPayment] = useState("");
  const [registrationStatus, setRegistrationStatus] = useState("");
  const navigate = useNavigate();
  const { login } = useUser();

  const registerGym = async () => {
    try {
      if (
        !gymName ||
        !gymPassword ||
        isNaN(parseFloat(monthlyPayment)) ||
        !location
      ) {
        setRegistrationStatus("Please enter valid information.");
        return;
      }

      const response = await Axios.post(
        "http://127.0.0.1:4500/api/gym/register",
        {
          gym_name: gymName,
          gym_password: gymPassword,
          gym_location: location,
          gym_monthly_payment: parseFloat(monthlyPayment),
        }
      );

      if (response.status === 201) {
        console.log(response.data.data);
        setRegistrationStatus("Gym registration successful");
        login(response.data.data);
        navigate("/");
      } else {
        setRegistrationStatus("Failed to register gym. Please try again.");
      }
    } catch (error) {
      console.error(error);
      setRegistrationStatus("Failed to register gym. Please try again.");
    }
  };

  return (
    <div className="registerPage flex">
      <div className="container flex">
        <div className="videoDiv">
          <video src={video} autoPlay muted loop></video>
          <div className="textDiv">
            <h2 className="title">Register Your Gym</h2>
            <p>Join our fitness community!</p>
          </div>
          <div className="footerDiv flex">
            <span className="text">Already registered?</span>
            <Link to="/login">
              <button className="btn">Login</button>
            </Link>
          </div>
        </div>
        <div className="formDiv flex">
          <div className="headerDiv">
            <img src={logo} alt="" />
            <h3>Welcome to the Gym Registration</h3>
          </div>
          <form action="" className="form grid">
            {registrationStatus && (
              <span className="showMessage">{registrationStatus}</span>
            )}

            <div className="inputDiv">
              <label htmlFor="gymName">Gym Name</label>
              <div className="input flex">
                <FaDumbbell className="icon" />
                <input
                  type="text"
                  id="gymName"
                  placeholder="Enter Gym Name"
                  onChange={(event) => {
                    setGymName(event.target.value);
                  }}
                />
              </div>
            </div>

            <div className="inputDiv">
              <label htmlFor="gymPassword">Password</label>
              <div className="input flex">
                <input
                  type="password"
                  id="gymPassword"
                  placeholder="Enter Password"
                  onChange={(event) => {
                    setGymPassword(event.target.value);
                  }}
                />
              </div>
            </div>

            <div className="inputDiv">
              <label htmlFor="monthlyPayment">Monthly Payment</label>
              <div className="input flex">
                <input
                  type="number"
                  id="monthlyPayment"
                  placeholder="Enter Monthly Payment"
                  onChange={(event) => {
                    setMonthlyPayment(event.target.value);
                  }}
                />
              </div>
            </div>

            <div className="inputDiv">
              <label htmlFor="location">Location</label>
              <div className="input flex">
                <input
                  type="text"
                  id="location"
                  placeholder="Enter Location"
                  onChange={(event) => {
                    setLocation(event.target.value);
                  }}
                />
              </div>
            </div>

            <button type="button" className="btn flex" onClick={registerGym}>
              <span>Register Gym</span>
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default RegisterGym;
