import { useEffect, useState } from "react";
import Single from "../../components/single/Single";
import "./user.scss";
import { User } from "../../types/user";

const UserProfile = () => {
  const [userData, setUserData] = useState<User | null>(null);

  useEffect(() => {
    // Make an API request to fetch user data
    // Replace 'your-api-endpoint' with the actual API endpoint
    fetch("your-api-endpoint") // Replace with the actual API endpoint
      .then((response) => response.json())
      .then((data: User) => {
        setUserData(data);
      })
      .catch((error) => {
        console.error("Error fetching user data:", error);
      });
  }, []);

  return (
    <div className="user">
      {userData && <Single user={userData} />}
      {/* Pass 'user' prop explicitly */}
    </div>
  );
};

export default UserProfile;
