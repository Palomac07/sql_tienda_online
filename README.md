# sql_tienda_online
Base de datos para tienda en línea
# Tienda en Línea - Base de Datos

Este proyecto es una implementación de una base de datos para una tienda en línea, diseñada para gestionar productos, clientes, pedidos, facturación, recomendaciones de productos, y reseñas. El proyecto está organizado en diferentes módulos para facilitar la gestión de datos y consultas avanzadas.

## Estructura del Proyecto

- **schema.sql**: Contiene la definición del esquema de la base de datos, incluyendo tablas y relaciones.
- **data.sql**: Incluye datos de ejemplo para poblar las tablas.
- **queries.sql**: Contiene consultas SQL comunes y avanzadas, como ventas por producto, total de compras por cliente, recomendaciones de productos, etc.
- **functions_triggers.sql**: Incluye triggers y funciones que automatizan la lógica de negocio.
- **indexes.sql**: Define índices para optimizar las consultas.
- **views.sql**: Contiene vistas para análisis de productos duplicados y métricas relacionadas.

## Características Especiales

### Sistema de Detección de Productos Duplicados

El sistema incluye un mecanismo completo para detectar y registrar intentos de agregar el mismo producto múltiples veces a un pedido:

- **Tabla ProductosDuplicados**: Registra todos los intentos de agregar productos duplicados a un pedido.
- **Trigger prevenir_productos_duplicados**: Detecta automáticamente cuando se intenta agregar un producto que ya existe en un pedido, registra el intento y previene la inserción duplicada.
- **Vistas de análisis**:
  - `vista_productos_duplicados`: Vista general de todos los productos duplicados detectados.
  - `vista_duplicados_detallada`: Información completa incluyendo datos del cliente y del producto.
  - `vista_productos_mas_duplicados`: Ranking de productos con más intentos de duplicación.
  - `vista_clientes_con_duplicados`: Identifica clientes con más intentos de productos duplicados.
  - `vista_duplicados_por_pedido`: Resumen de duplicados agrupados por pedido.

Este sistema permite mantener la integridad de los pedidos mientras se recopila información valiosa sobre los intentos de duplicación para análisis y mejora de la experiencia del usuario.

## Requisitos

- MySQL (o cualquier base de datos compatible con SQL).
- Cliente SQL (puede ser MySQL Workbench, DBeaver, etc.).

## Cómo Ejecutar el Proyecto

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/tuusuario/sql_tienda_online.git
