import React, { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { Outlet } from "react-router-dom";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import Navbar from "./components/navbar/Navbar";
import Menu from "./components/menu/Menu";
import { useUser } from "./context/UserContext";
import "./styles/global.scss";
//import Footer from "./components/footer/Footer";

const queryClient = new QueryClient();
const App: React.FC = () => {
  const { user } = useUser();
  const navigate = useNavigate();

  useEffect(() => {
    // Call navigate inside the useEffect hook
    if (!user) {
      navigate("/login");
    }
  }, [user, navigate]);

  console.log("User:", user);

  // Return the main component tree with Routes
  return (
    <div className="main">
      <Navbar />
      <div className="container">
        <div className="menuContainer">
          <Menu />
        </div>
        <div className="contentContainer">
          <QueryClientProvider client={queryClient}>
            <Outlet />
          </QueryClientProvider>
        </div>
      </div>
      {/* <Footer /> */}
    </div>
  );
};

export default App;
