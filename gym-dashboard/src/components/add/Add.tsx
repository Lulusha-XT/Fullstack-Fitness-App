import { GridColDef } from "@mui/x-data-grid";
import "./add.scss";
import { useState } from "react";

// ... (import statements)

type Props = {
  slug: string;
  columns: GridColDef[];
  setOpen: React.Dispatch<React.SetStateAction<boolean>>;
  onAddUser: (newUser: any) => void; // Callback to add a new user
};

const Add = (props: Props) => {
  const [formData, setFormData] = useState<any>({});
  const [imageFile, setImageFile] = useState<File | null>(null);
  const [successMessage, setSuccessMessage] = useState<string | null>(null);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    try {
      const formDataToSend = new FormData();

      // Add JSON data to FormData
      Object.keys(formData).forEach((key) => {
        formDataToSend.append(key, formData[key]);
      });

      // Add image file to FormData
      if (imageFile) {
        formDataToSend.append("image", imageFile);
      }

      // Send a POST request to your server to add a new user
      const response = await fetch(`http://127.0.0.1:4500/api/${props.slug}`, {
        method: "POST",
        body: formDataToSend,
      });

      if (response.ok) {
        const newUser = await response.json();
        setSuccessMessage("Post added successfully!");
        props.onAddUser(newUser); // Call the callback to add the new user to your UI
        props.setOpen(false); // Close the modal
      } else {
        const errorText = await response.text();
        setErrorMessage(`Error adding post: ${response.status} - ${errorText}`);
      }
    } catch (error: any) {
      setErrorMessage(`Error adding post: ${error.message}`);
    }
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData((prevData: any) => ({ ...prevData, [name]: value }));
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files && e.target.files[0];
    if (file) {
      setImageFile(file);
    }
  };

  return (
    <div className="add">
      <div className="modal">
        <span className="close" onClick={() => props.setOpen(false)}>
          X
        </span>
        <h1>Add new {props.slug}</h1>
        <form onSubmit={handleSubmit}>
          {props.columns
            .filter((item) => item.field !== "id")
            .map((column) => (
              <div className="item" key={column.field}>
                <label>{column.headerName}</label>
                {column.type === "text" ? (
                  <input
                    type="text"
                    placeholder={column.headerName}
                    name={column.field}
                    value={formData[column.field] || ""}
                    onChange={handleInputChange}
                    required
                  />
                ) : (
                  <input
                    type="file"
                    name={column.field}
                    onChange={handleFileChange}
                    required
                  />
                )}
              </div>
            ))}
          <button type="submit">Send</button>
        </form>
        {successMessage && (
          <div className="success-message">{successMessage}</div>
        )}
        {errorMessage && <div className="error-message">{errorMessage}</div>}
      </div>
    </div>
  );
};

export default Add;
