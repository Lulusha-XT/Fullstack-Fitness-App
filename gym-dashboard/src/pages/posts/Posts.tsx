import { GridColDef } from "@mui/x-data-grid";
import "./posts.scss";
import { useEffect, useState } from "react";
import { useUser } from "../../context/UserContext";
import Add from "../../components/add/Add";
import PostDataTable from "../../components/dataTable/PostDataTable";
import { Post } from "../../types/post";

const columns: GridColDef[] = [
  {
    field: "id",
    headerName: "Post ID",
    width: 100,
    type: "text",
  },
  {
    field: "gym_id",
    headerName: "Gym ID",
    width: 100,
    type: "text",
  },
  {
    field: "post_description",
    headerName: "Post Description",
    width: 200,
    type: "text",
  },
  {
    field: "post_image_path",
    headerName: "Image",
    type: "string", // Change the type to "string"
    width: 100,
    renderCell: (params) => {
      return (
        <img
          src={`http://127.0.0.1:4500/${params.value || "/default-avatar.png"}`}
          alt="Profile"
        />
      );
    },
  },
];

const Posts = () => {
  const [open, setOpen] = useState(false);
  const [data, setData] = useState<Post[]>([]);
  const { user } = useUser();

  const onAddUser = async () => {
    try {
    } catch (error) {
      console.error(error);
    }
  };
  useEffect(() => {
    if (user && user.user.gym_id) {
      fetch(`http://127.0.0.1:4500/api/gympost/post/${user.user.gym_id}`)
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
        <h1>Posts</h1>
        <button onClick={() => setOpen(true)}>Add New Post</button>
      </div>
      <PostDataTable slug="users" columns={columns} rows={data} />
      {open && (
        <Add
          slug="gympost"
          columns={columns}
          setOpen={setOpen}
          onAddUser={onAddUser}
        />
      )}
    </div>
  );
};

export default Posts;
