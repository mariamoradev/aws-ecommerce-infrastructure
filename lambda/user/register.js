exports.handler = async (event) => {
  console.log("Evento recibido:", event);
  return {
    statusCode: 200,
    body: JSON.stringify({ message: "Usuario registrado exitosamente" }),
  };
};
