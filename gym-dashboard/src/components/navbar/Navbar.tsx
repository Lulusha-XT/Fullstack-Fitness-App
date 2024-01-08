import { useState } from "react";
import { useUser } from "./../../context/UserContext";
import "./navbar.scss";

const Navbar = () => {
  const { user, logout } = useUser(); // Use the useUser hook to access user data and logout function
  const [isDropdownOpen, setIsDropdownOpen] = useState(false); // State to manage the dropdown menu

  const toggleDropdown = () => {
    setIsDropdownOpen(!isDropdownOpen);
  };

  const handleLogout = () => {
    logout(); // Call the logout function from the UserContext
    setIsDropdownOpen(false); // Close the dropdown after logging out
  };

  return (
    <div className="navbar">
      <div className="logo">
        <img src="logo.svg" alt="" />
        <span>Dashboard</span>
      </div>
      <div className="icons">
        {user && (
          <div className="user" onClick={toggleDropdown}>
            <img src={user.user.gym_image} alt="" />
            <span>{user.user.gym_name}</span>
            {isDropdownOpen && (
              <div className="dropdown-menu">
                <button onClick={handleLogout}>Logout</button>
              </div>
            )}
          </div>
        )}
        <img
          src="/settings.svg"
          alt=""
          onClick={toggleDropdown}
          className={isDropdownOpen ? "active" : ""}
        />
      </div>
    </div>
  );
};

export default Navbar;
