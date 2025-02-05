<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>example.html</title>
    <style>
        .carousel-item img {
            height: 70vh;
            width: 100%;
            object-fit: cover;
        }
        footer {
            font-size: 0.9rem;
            padding: 10px 0;
        }
        footer .text-center p,
        footer .text-center a {
            margin-bottom: 5px;
        }
        .container {
            margin-top: 20px;
            margin-bottom: 10px;
        }
        .nav-item.dropdown:hover .dropdown-menu {
            display: block !important;
        }
        .dropdown-menu {
            position: absolute;
            top: 100%;
            left: 0;
            z-index: 1000;
        }
    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
