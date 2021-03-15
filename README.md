<h1>Creador masivo de usuarios de prueba de AD</h1>

<p>El objetivo de este script es realizar creaciones masivas de usuarios listos para ser cargados en un directorio activo, para esta tarea yo he utilizado un csv que contiene nombres y apellidos, generando un nuevo csv que genera nombres aleatorios junto con otros datos esenciales para la carga de los mismos</p>

<h2> Requerimientos </h2>
<ul>
    <li>Python 3.X</li>
    <li>Windows Server 2012 R2 o superior</li>
</ul>

<h2>Forma de utilizacion</h2>

<ul>
    <li>Clonar o descargar repositorio</li>
    <li>En el archivo Usuarios_AD.py, indicar el path correspondiente al archivo de nombres y apellidos.</li>
    <li>Ejecutar el archivo Usuarios_AD.py con python</li>
    <li>Copiar el archivo <strong>usuarios_ad.csv</strong> en servidor Windows junto al archivo <strong> AD_upload.ps1</strong></li>
    <li>Una vez copiados dentro del servidor, abrir una terminal de powershell como administrador y setear el Set-ExecutionPolicy en RemoteSigned <strong> "Set-ExecutionPolicy RemoteSigned"</strong></li>
    <li>Ejecutar el archivo AD_upload.ps1 con el siguiente comando: <strong>.\AD_upload.ps1</strong></li>
</ul>

<h2>Notas</h2>
<p>Pueden utilizar otros archivos de nombres, solo deben estar atentos a la posicion en donde se encuentran estos valores y hacer las modificaciones correspondientes en el archivo .py