import { GridColDef } from "@mui/x-data-grid";
import DataTable from "../../components/dataTable/DataTable";
import "./Users.scss";
import { useEffect, useState } from "react";
import { User } from "../../types/user";
import { useUser } from "../../context/UserContext";

const columns: GridColDef[] = [
  {
    field: "user_id",
    headerName: "ID",
    width: 60,
  },
  {
    field: "profile_picture",
    headerName: "Profile",
    width: 100,
    renderCell: (params) => {
      return <img src={params.value || "/default-avatar.png"} alt="Profile" />;
    },
  },
  {
    field: "full_name",
    headerName: "Full Name",
    width: 100,
  },
  {
    field: "gender",
    headerName: "Gender",
    width: 60,
  },
  {
    field: "age",
    headerName: "Age",
    type: "number",
    width: 50,
  },
  {
    field: "email",
    headerName: "Email",
    width: 100,
  },
  {
    field: "phone_number",
    headerName: "Phone Number",
    width: 150,
  },
  {
    field: "aim",
    headerName: "Aim",
    width: 100,
  },
  {
    field: "activity_extent",
    headerName: "Activity Extent",
    width: 100,
  },
];

const Users = () => {
  const [data, setData] = useState<User[]>([]);
  const { user } = useUser();

  useEffect(() => {
    if (user && user.user.gym_id) {
      fetch(`http://127.0.0.1:4500/api/gym/user/${user.user.gym_id}`)
        .then((response) => response.json())
        .then((responseData) => {
          if (Array.isArray(responseData.data)) {
            setData(responseData.data);
          } else {
            setData([responseData.data]);
          }
        })
        .catch((error) => {
          console.error("Error fetching user data:", error);
        });
    }
  }, [user]);

  return (
    <div className="users">
      <div className="info">
        <h1>Users</h1>
      </div>
      <DataTable slug="users" columns={columns} rows={data} />
    </div>
  );
};

export default Users;
