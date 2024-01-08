import React, { useEffect, useState } from "react";
import BarChartBox from "../../components/barChartBox/BarChartBox";
import BigChartBox from "../../components/bigChartBox/BigChartBox";
import ChartBox from "../../components/chartBox/ChartBox";
import PieChartBox from "../../components/pieChartBox/PieChartBox";
import TopBox from "../../components/topBox/TopBox";
import { useUser } from "../../context/UserContext";
import {
  barChartBoxRevenue,
  barChartBoxVisit,
  chartBoxConversion,
  chartBoxProduct,
  chartBoxRevenue,
  chartBoxUser,
} from "../../data";
import "./home.scss";
const Home = () => {
  const [userCount, setUserCount] = useState(0);
  const { user } = useUser(); // Access user data from UserContext

  useEffect(() => {
    if (user) {
      // Assuming you have a gym_id in your user data, use it to fetch the count
      const gymId = user.user.gym_id;

      // Fetch the gym user count based on the gymId
      fetch(`http://127.0.0.1:4500/api/gym/usercount/${gymId}`)
        .then((response) => response.json())
        .then((userCountData) => {
          setUserCount(userCountData.data); // Set the user count in state
        })
        .catch((error) => {
          console.error("Error fetching user count:", error);
        });
    }
  }, [user]);

  return (
    <div className="home">
      {/* <div className="box box1">
        <TopBox />
      </div> */}
      <div className="box box5">
        <ChartBox {...chartBoxUser} number={userCount} />
      </div>
      {/* <div className="box box3">
        <ChartBox {...chartBoxProduct} />
      </div> */}
      {/* <div className="box box4">
        <PieChartBox />
      </div>
      <div className="box box5">
        <ChartBox {...chartBoxConversion} />
      </div>
      <div className="box box6">
        <ChartBox {...chartBoxRevenue} />
      </div>
      <div className="box box7">
        <BigChartBox />
      </div>
      <div className="box box8">
        <BarChartBox {...barChartBoxVisit} />
      </div>
      <div className="box box9">
        <BarChartBox {...barChartBoxRevenue} />
      </div> */}
    </div>
  );
};

export default Home;
