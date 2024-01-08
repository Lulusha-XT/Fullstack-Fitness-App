// Import necessary dependencies
import {
  createContext,
  useContext,
  useState,
  useEffect,
  ReactNode,
} from "react";

// Define the User and UserData interfaces
interface User {
  token: string;
  user: GymData;
}

interface GymData {
  gym_id: number;
  gym_name: string;
  gym_monthly_payment: number;
  gym_image?: string;
  token: string;
  // Add other user data properties as needed
}

// Define the UserContextType interface
interface UserContextType {
  user: User | null;
  login: (gymData: GymData) => void; // Modify the login function signature
  logout: () => void;
}

// Create the UserContext
const UserContext = createContext<UserContextType | undefined>(undefined);

// Create the useUser hook for easy access to user data
export const useUser = () => {
  const context = useContext(UserContext);
  if (!context) {
    throw new Error("useUser must be used within a UserProvider");
  }
  return context;
};

// Create the UserProvider component
export const UserProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<User | null>(null);

  // Load user data from local storage on component mount
  useEffect(() => {
    const storedToken = localStorage.getItem("token");
    const storedUser = localStorage.getItem("user");

    if (storedToken && storedUser) {
      setUser({ token: storedToken, user: JSON.parse(storedUser) });
    }
  }, []);

  // Login function to set user data and store in local storage
  const login = (gymData: GymData) => {
    console.error(`Gym data token ${gymData.token}`);
    setUser({ token: gymData.token, user: gymData });
    localStorage.setItem("token", gymData.token);
    localStorage.setItem("user", JSON.stringify(gymData));
  };

  // Logout function to clear user data and local storage
  const logout = () => {
    setUser(null);
    localStorage.removeItem("token");
    localStorage.removeItem("user");
  };

  return (
    <UserContext.Provider value={{ user, login, logout }}>
      {children}
    </UserContext.Provider>
  );
};
