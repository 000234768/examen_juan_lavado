# Documentación de la API

Este documento ofrece una visión general de los endpoints de la API disponibles para el sistema de gestión de productos. A continuación, se agrupan los endpoints por recursos, incluyendo productos, categorías y proveedores.

## Autenticación

**Usuario:** `juan.lavado@mayor.cl`  
**Contraseña:** `juan1234`

Asegúrate de autenticarte utilizando las credenciales anteriores para acceder a los endpoints de la API.

## Endpoints

### Productos

- **Listar Productos**
  - **Método:** GET
  - **Endpoint:** `ejemplos/product_list_rest/`
- **Agregar Producto**
  - **Método:** POST
  - **Endpoint:** `ejemplos/product_add_rest/`
  - **Ejemplo de Payload:**
    ```json
    {
      "product_name": "nombre",
      "product_price": 100,
      "product_image": "https://emprendepyme.net/wp-content/uploads/2023/03/cualidades-producto-1200x900.jpg"
    }
    ```
- **Editar Producto**
  - **Método:** POST
  - **Endpoint:** `ejemplos/product_edit_rest/`
  - **Ejemplo de Payload:**
    ```json
    {
      "product_id": 1,
      "product_name": "nombre",
      "product_price": 100,
      "product_image": "https://emprendepyme.net/wp-content/uploads/2023/03/cualidades-producto-1200x900.jpg",
      "product_state": "Activo"
    }
    ```
- **Eliminar Producto**
  - **Método:** POST
  - **Endpoint:** `ejemplos/product_del_rest/`
  - **Ejemplo de Payload:**
    ```json
    {
      "product_id": 1
    }
    ```

### Categorías

- **Listar Categorías**
  - **Método:** GET
  - **Endpoint:** `ejemplos/category_list_rest/`
- **Agregar Categoría**
  - **Método:** POST
  - **Endpoint:** `ejemplos/category_add_rest/`
  - **Ejemplo de Payload:**
    ```json
    {
      "category_name": "nombre"
    }
    ```
- **Editar Categoría**
  - **Método:** POST
  - **Endpoint:** `ejemplos/category_edit_rest/`
  - **Ejemplo de Payload:**
    ```json
    {
      "category_id": 1,
      "category_name": "nombre",
      "category_state": "Activa"
    }
    ```
- **Eliminar Categoría**
  - **Método:** POST
  - **Endpoint:** `ejemplos/category_del_rest/`
  - **Ejemplo de Payload:**
    ```json
    {
      "category_id": 1
    }
    ```

### Proveedores

- **Listar Proveedores**
  - **Método:** GET
  - **Endpoint:** `ejemplos/provider_list_rest/`
- **Agregar Proveedor**
  - **Método:** POST
  - **Endpoint:** `ejemplos/provider_add_rest/`
  - **Ejemplo de Payload:**
    ```json
    {
      "provider_name": "nombre",
      "provider_last_name": "apellido",
      "provider_mail": "correo@correo.cl",
      "provider_state": "Activo"
    }
    ```
- **Editar Proveedor**
  - **Método:** POST
  - **Endpoint:** `ejemplos/provider_edit_rest/`
  - **Ejemplo de Payload:**
    ```json
    {
      "provider_id": 1,
      "provider_name": "nombre",
      "provider_last_name": "apellido",
      "provider_mail": "correo@correo.cl",
      "provider_state": "Activo"
    }
    ```
- **Eliminar Proveedor**
  - **Método:** POST
  - **Endpoint:** `ejemplos/provider_del_rest/`
  - **Ejemplo de Payload:**
    ```json
    {
      "provider_id": 1
    }
    ```

## Información Adicional

A lo largo de la configuración y ajuste de nuestro sistema, hemos realizado diversas mejoras para optimizar el uso de la API y mejorar la interfaz de usuario para la gestión de productos, categorías y proveedores. Esto incluye mejoras en la visual
